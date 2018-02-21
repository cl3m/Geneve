//
//  PhonebookController.m
//  Genève
//
//  Created by Clem on 13.07.09.
//  Copyright 2009 ROUGE41. All rights reserved.
//

#import "PhonebookController.h"


@implementation PhonebookController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:self.title];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   switch (section) {
	   case 0 : return 10;break;
	   case 1 : return 8;break;
	   case 2 : return 14;break;
	   case 3 : return 2;break;
	   case 4 : return 6;break;
	   case 5 : return 3;break;
	   default: return 0;
   }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0 : return @"Numéros d'urgence";break;
		case 1 : return @"Hôpitaux universitaires de Genève";break;
		case 2 : return @"Médecine";break;
		case 3 : return @"Animaux";break;
		case 4 : return @"Taxis";break;
		case 5 : return @"Divers";break;
		default: return nil;break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.font = [UIFont systemFontOfSize:17.0];
		cell.detailTextLabel.font = [UIFont boldSystemFontOfSize: 14.0];
		
    }
    
    // Set up the cell...
	switch (indexPath.section) {
		case 0: switch (indexPath.row) {
			case 0 : cell.textLabel.text = @"Police";cell.detailTextLabel.text=@"117";break;
			case 1 : cell.textLabel.text = @"Feu";cell.detailTextLabel.text=@"118";break;
			case 2 : cell.textLabel.text = @"Ambulances et médecins";cell.detailTextLabel.text=@"144";break;
			case 3 : cell.textLabel.text = @"Rega";cell.detailTextLabel.text=@"1414";break;
			case 4 : cell.textLabel.text = @"Air-Glaciers";cell.detailTextLabel.text=@"1415";break;
			case 5 : cell.textLabel.text = @"Empoisonnements";cell.detailTextLabel.text=@"145";break;
			case 6 : cell.textLabel.text = @"Secours routier";cell.detailTextLabel.text=@"140";break;
			case 7 : cell.textLabel.text = @"Environnement";cell.detailTextLabel.text=@"118";break;
			case 8 : cell.textLabel.text = @"La Main Tendue";cell.detailTextLabel.text=@"143";break;
			case 9 : cell.textLabel.text = @"Aide pour les jeunes";cell.detailTextLabel.text=@"147";break;
			default: cell.textLabel.text = @"default";break;
		}; break;
		case 1: switch (indexPath.row) {
			case 0 : cell.textLabel.text = @"Centrale";cell.detailTextLabel.text=@"0223723311";break;
			case 1 : cell.textLabel.text = @"Gynécologie";cell.detailTextLabel.text=@"0223826816";break;
			case 2 : cell.textLabel.text = @"Maternité";cell.detailTextLabel.text=@"0223826816";break;
			case 3 : cell.textLabel.text = @"Obstétrie (accouchements)";cell.detailTextLabel.text=@"0223824236";break;
			case 4 : cell.textLabel.text = @"Ophtalmologie (jour)";cell.detailTextLabel.text=@"0223826435";break;
			case 5 : cell.textLabel.text = @"Ophtalmologie (nuit)";cell.detailTextLabel.text=@"0223828416";break;
			case 6 : cell.textLabel.text = @"Pédiatrie";cell.detailTextLabel.text=@"0223824555";break;
			case 7 : cell.textLabel.text = @"Psychiatrie";cell.detailTextLabel.text=@"0223723862";break;
			default: cell.textLabel.text = @"default";break;
		}; break;
		case 2: switch (indexPath.row) {
			case 0 : cell.textLabel.text = @"Hôpital de la Tour";cell.detailTextLabel.text=@"0227196111";break;
			case 1 : cell.textLabel.text = @"Clinique de Carouge";cell.detailTextLabel.text=@"0223094545";break;
			case 2 : cell.textLabel.text = @"AMG - Urgences à domicile";cell.detailTextLabel.text=@"0223212121";break;
			case 3 : cell.textLabel.text = @"SOS Médecins à domicile 24h/24";cell.detailTextLabel.text=@"0227484950";break;
			case 4 : cell.textLabel.text = @"Genève-Médecins 24h/24";cell.detailTextLabel.text=@"0227545454";break;
			case 5 : cell.textLabel.text = @"SOS Infirmières 24h/24";cell.detailTextLabel.text=@"0224202464";break;
			case 6 : cell.textLabel.text = @"STOP-Suicide 24h/24";cell.detailTextLabel.text=@"0223824242";break;
			case 7 : cell.textLabel.text = @"Clinique des Grangettes 7h-23h";cell.detailTextLabel.text=@"0223050777";break;
			case 8 : cell.textLabel.text = @"Permanence de Cornavin";cell.detailTextLabel.text=@"0223454550";break;
			case 9 : cell.textLabel.text = @"Groupe médical d'Onex 24h/24";cell.detailTextLabel.text=@"0228795050";break;
			case 10: cell.textLabel.text = @"Policlinique chirurgie et médecine";cell.detailTextLabel.text=@"0223726408";break;
			case 11: cell.textLabel.text = @"Centre Médical du Léman";cell.detailTextLabel.text=@"0227160660";break;
			case 12: cell.textLabel.text = @"Association des chiropraticiens";cell.detailTextLabel.text=@"0227818200";break;
			case 13: cell.textLabel.text = @"Association des Médecins-dentistes";cell.detailTextLabel.text=@"111";break;
			default: cell.textLabel.text = @"default";break;
		}; break;
		case 3: switch (indexPath.row) {
			case 0 : cell.textLabel.text = @"Vétérinaires de garde (1.50/min)";cell.detailTextLabel.text=@"0900838343";break;
			case 1 : cell.textLabel.text = @"Fourrière cantonale pour chiens";cell.detailTextLabel.text=@"0227741408";break;
			default: cell.textLabel.text = @"default";break;
		}; break;
		case 4: switch (indexPath.row) {
			case 0 : cell.textLabel.text = @"AA New CAB SA";cell.detailTextLabel.text=@"0223202020";break;
			case 1 : cell.textLabel.text = @"ABC Mont-Blanc";cell.detailTextLabel.text=@"0223283030";break;
			case 2 : cell.textLabel.text = @"Coopérative Taxis 202";cell.detailTextLabel.text=@"0223202202";break;
			case 3 : cell.textLabel.text = @"AB EUROPA Taxis";cell.detailTextLabel.text=@"0229067979";break;
			case 4 : cell.textLabel.text = @"Taxis-Phone SA";cell.detailTextLabel.text=@"0223314133";break;
			case 5 : cell.textLabel.text = @"Taxis Ambassador Sàrl";cell.detailTextLabel.text=@"0227319270";break;
			default: cell.textLabel.text = @"default";break;
		}; break;
		case 5: switch (indexPath.row) {
			case 0 : cell.textLabel.text = @"Services industriels de Genève";cell.detailTextLabel.text=@"0224208811";break;
			case 1 : cell.textLabel.text = @"Service de l'heure";cell.detailTextLabel.text=@"161";break;
			case 2 : cell.textLabel.text = @"Prévisions Météorologiques";cell.detailTextLabel.text=@"162";break;
			default: cell.textLabel.text = @"default";break;
		}; break;
		default: cell.textLabel.text = @"default"; break;
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	NSURL *url = [NSURL URLWithString:[NSString
									   stringWithFormat:@"tel:%@",cell.detailTextLabel.text]];
	[[UIApplication sharedApplication] openURL:url];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:cell.textLabel.text];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

@end
