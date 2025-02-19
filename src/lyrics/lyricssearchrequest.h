/*
* Strawberry Music Player
* Copyright 2018-2021, Jonas Kvinge <jonas@jkvinge.net>
*
* Strawberry is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Strawberry is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Strawberry.  If not, see <http://www.gnu.org/licenses/>.
*
*/

#ifndef LYRICSSEARCHREQUEST_H
#define LYRICSSEARCHREQUEST_H

#include <QtGlobal>
#include <QString>

class LyricsSearchRequest {
 public:
  explicit LyricsSearchRequest() {}
  QString albumartist;
  QString artist;
  QString album;
  QString title;
};

Q_DECLARE_METATYPE(LyricsSearchRequest)

#endif  // LYRICSSEARCHREQUEST_H
