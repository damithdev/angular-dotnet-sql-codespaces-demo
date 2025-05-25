import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { CustomerComponent } from './customer/customer.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CustomerComponent],
  template: `
    <app-customer></app-customer>
  `
})
export class AppComponent {
  title = 'frontend-app';
}
