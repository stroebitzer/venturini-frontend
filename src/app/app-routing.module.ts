import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ClientsComponent } from './components/clients/clients.component';
import { OrdersComponent } from './components/orders/orders.component';
import { QrCodeComponent } from './components/qr-code/qr-code.component';

const routes: Routes = [
  { path: 'qr-code', component: QrCodeComponent },
  { path: 'clients', component: ClientsComponent },
  { path: 'orders', component: OrdersComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
