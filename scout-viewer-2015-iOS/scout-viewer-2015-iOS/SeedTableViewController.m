//
//  SeedTableViewController.m
//  scout-viewer-2015-iOS
//
//  Created by Citrus Circuits on 2/8/15.
//  Copyright (c) 2015 Citrus Circuits. All rights reserved.
//

#import "seedTableViewController.h"

#import "config.h"
#import "MultiCellTableViewCell.h"
#import "scout_viewer_2015_iOS-Swift.h"


@interface SeedTableViewController ()

@end

@implementation SeedTableViewController


-(void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)path forData:(id)data inTableView:(UITableView *)tableView {
    Team *team = data;
    
    MultiCellTableViewCell *multiCell = (MultiCellTableViewCell *)cell;
    if(team.calculatedData.actualSeed != nil) {
    multiCell.rankLabel.text = [NSString stringWithFormat:@"%ld", (long)team.calculatedData.actualSeed.integerValue];
    } else {
        multiCell.rankLabel.text = [NSString stringWithFormat:@"%ld",(long)path.row];
    }
    multiCell.teamLabel.text = [NSString stringWithFormat:@"%ld", (long)team.number.integerValue];
    if(team.calculatedData.firstPickAbility != nil) {
    multiCell.scoreLabel.text = [NSString stringWithFormat:@"%@",
                                 [Utils roundValue:team.calculatedData.firstPickAbility.floatValue toDecimalPlaces:2]];
    } else {
        multiCell.scoreLabel.text = @"";
    }
    //Ask about this
}

- (NSString *)cellIdentifier {
    return MULTI_CELL_IDENTIFIER;
}

- (NSArray *)loadDataArray:(BOOL)shouldForce {
    NSArray *returnData = [self.firebaseFetcher fetchTeamsByDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"seed" ascending:YES]];
    NSLog(@"%lu", (unsigned long)returnData.count);
    return returnData;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"TeamDetails" sender:[tableView cellForRowAtIndexPath:indexPath]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[TeamDetailsTableViewController class]]) {
        MultiCellTableViewCell *multiCell = sender;
    
        TeamDetailsTableViewController *teamDetailsController = segue.destinationViewController;
    
        
        //Team *team = [self.firebaseFetcher fetchTeam:[multiCell.teamLabel.text integerValue]];
        teamDetailsController.data = [self.firebaseFetcher fetchTeam:[multiCell.teamLabel.text integerValue]];
    }
}

- (NSArray *)filteredArrayForSearchText:(NSString *)searchString inScope:(NSInteger)scope
{
    return [self.dataArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Team *team, NSDictionary *bindings) {
        if(team.number == nil) {
            
        }
        NSString *numberText = [NSString stringWithFormat:@"%ld", (long)team.number];
        return [numberText rangeOfString:searchString].location == 0;
    }]];
}


@end
