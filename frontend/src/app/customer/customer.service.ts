import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Customer } from './customer';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {

  private get apiUrl(): string {
    const { hostname, protocol } = window.location;
    return hostname.includes('4200')
      ? `${protocol}//${hostname.replace('4200', '5000')}/api/customer`
      : 'http://localhost:5000/api/customer';
  }


  constructor(private http: HttpClient) {}

  getCustomers(): Observable<Customer[]> {
    return this.http.get<Customer[]>(this.apiUrl);
  }

  addCustomer(customer: Customer): Observable<Customer> {
    return this.http.post<Customer>(this.apiUrl, customer);
  }
}
