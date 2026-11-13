using {govardhanraju.cds} from '../db/CDSViews';

service CDSService @(path: 'CDSservice') {
    entity ProductSet as projection on cds.CDSViews.ProductView;
    entity ItemSet as projection on cds.CDSViews.ItemView;
}