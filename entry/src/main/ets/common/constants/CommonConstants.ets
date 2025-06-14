/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

export interface Route {
  title: ResourceStr;
  to: string;
};

export const ROUTES: Route[] = [
  {
    title: $r('app.string.title_navigation_transition'),
    to: 'NavigationTransition'
  },
  {
    title: $r('app.string.title_custom_transition'),
    to: 'CustomNavigationTransition'
  },
  {
    title: $r('app.string.title_component_transition'),
    to: 'ComponentTransition'
  },
  {
    title: $r('app.string.title_modal_transition'),
    to: 'ModalTransition'
  },
  {
    title: $r('app.string.title_share_item'),
    to: 'GeometryTransition'
  },
  {
    title: $r('app.string.title_long_take_transition'),
    to: 'LongTakeTransition'
  }
];


/**
 * Share transition id.
 */
export const GEOMETRY_TRANSITION_ID: string = 'shareId';


/**
 * Common constants for all features.
 */
export default class CommonConstants {
  /**
   * The sql of creating sports table.
   */
  static readonly CREATE_SPORTS_TABLE_SQL: string =
    'CREATE TABLE IF NOT EXISTS SPORTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT ' +
      'NOT NULL, TYPE TEXT NOT NULL)';

  /**
   * The sql of creating plans table.
   */
  static readonly CREATE_PLANS_TABLE_SQL: string =
    'CREATE TABLE IF NOT EXISTS PLANS (ID INTEGER PRIMARY KEY AUTOINCREMENT, SPORT_ID INTEGER ' +
      'NOT NULL, DURATION INTEGER NOT NULL, STATUS TEXT NOT NULL)';

  /**
   * The sql of querying all durations.
   */
  static readonly QUERY_ALL_DURATIONS_SQL: string =
    'SELECT DISTINCT DURATION FROM PLANS';

  /**
   * The sql of query all plans.
   */
  static readonly QUERY_ALL_PLANS_SQL: string =
    'SELECT p.id AS ID,s.NAME AS NAME,s.type AS TYPE,p.DURATION AS DURATION,p.STATUS AS STATUS FROM SPORTS AS s ' +
      'JOIN PLANS AS p WHERE s.ID = P.SPORT_ID';

  /**
   * The sql of querying plans by duration.
   */
  static readonly QUERY_PLANS_BY_DURATION_SQL: string =
    'SELECT p.id AS ID,s.NAME AS NAME,s.type AS TYPE,p.DURATION AS DURATION,p.STATUS AS STATUS FROM SPORTS AS s' +
      ' JOIN PLANS AS p WHERE s.ID = P.SPORT_ID AND p.DURATION = ';

  /**
   * The sql of querying plans by status.
   */
  static readonly QUERY_PLANS_BY_STATUS_SQL: string =
    'SELECT p.id AS ID,s.NAME AS NAME,s.type AS TYPE,p.DURATION AS DURATION,p.STATUS AS STATUS FROM SPORTS AS s' +
      ' JOIN PLANS AS p WHERE s.ID = P.SPORT_ID AND p.STATUS = "';
}