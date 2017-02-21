//
//  DRViewController.m
//  SearchBarView
//
//  Created by Axel Ulises Díaz Reyes on 09/07/14.
//  Copyright (c) 2014 Axel Ulises Díaz Reyes. All rights reserved.
//

#import "DRViewController.h"

@interface DRViewController ()

@property (strong,nonatomic) NSArray *arreglo; //inicializamos el arreglo
@property (strong, nonatomic) NSArray *resultadoBusqueda; //EN este arreglo se almacena los datos ingresadons en la SB



@end

@implementation DRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arreglo = [[NSArray alloc]initWithObjects:@"Apple",@"Samsung",@"Toshiba",@"Sony",@"HTC", nil];
    
    self.resultadoBusqueda = [[NSArray alloc] init];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView) //Si el search bar tiene los datos que los muestre en la tabla
    {
        return [self.resultadoBusqueda count];
        //return [self.arreglo count];
    }
    else
    {
        return [self.arreglo count];
    }
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [self.resultadoBusqueda objectAtIndex: indexPath.row];
    }
    else
    {
        cell.textLabel.text = [self.arreglo objectAtIndex:indexPath.row];
    }
    //  cell.textLabel.text = [self.arreglo objectAtIndex:indexPath.row];
    return cell;
}

#pragma Search Methods

-(void) filterContentForSeachText:(NSString *) seachText scope:(NSString *) scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",seachText];
    self.resultadoBusqueda = [self.arreglo filteredArrayUsingPredicate:predicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSeachText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}



@end
