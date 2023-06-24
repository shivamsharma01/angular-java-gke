import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AppService {
  constructor(private http: HttpClient) {}

  rootURL = '/api';

  getUsers(): Observable<Object> {
    return this.http.get(this.rootURL + '/users');
  }

  addUser(user: any, id: number) {
    user.id = id;
    return this.http.post(this.rootURL + '/user', user);
  }
}
