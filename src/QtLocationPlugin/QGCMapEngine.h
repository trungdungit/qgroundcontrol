/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


/**
 * @file
 *   @brief Map Tile Cache
 *
 *   @author Gus Grubba <gus@auterion.com>
 *
 */

#ifndef QGC_MAP_ENGINE_H
#define QGC_MAP_ENGINE_H

#include <QString>

#include "QGCMapUrlEngine.h"
#include "QGCMapEngineData.h"
#include "QGCTileCacheWorker.h"


//-----------------------------------------------------------------------------
class QGCMapEngine : public QObject
{
    Q_OBJECT
public:
    QGCMapEngine                ();
    ~QGCMapEngine               ();

    void                        init                ();
    void                        addTask             (QGCMapTask *task);
    void                        cacheTile           (const QString& type, int x, int y, int z, const QByteArray& image, const QString& format, qulonglong set = UINT64_MAX);
    void                        cacheTile           (const QString& type, const QString& hash, const QByteArray& image, const QString& format, qulonglong set = UINT64_MAX);
    QGCFetchTileTask*           createFetchTileTask (const QString& type, int x, int y, int z);
    QStringList                 getMapNameList      ();
    const QString               userAgent           () { return _userAgent; }
    void                        setUserAgent        (const QString& ua) { _userAgent = ua; }
    QString                     tileHashToType      (const QString& tileHash);
    QString                     getTileHash         (const QString& type, int x, int y, int z);
    quint32                     getMaxDiskCache     ();
    quint32                     getMaxMemCache      ();
    const QString               getCachePath        () { return _cachePath; }
    const QString               getCacheFilename    () { return _cacheFile; }
    void                        testInternet        ();
    bool                        wasCacheReset       () const{ return _cacheWasReset; }
    bool                        isInternetActive    () const{ return _isInternetActive; }

    UrlFactory*                 urlFactory          () { return _urlFactory; }

    //-- Tile Math
    static QGCTileSet           getTileCount        (int zoom, double topleftLon, double topleftLat, double bottomRightLon, double bottomRightLat, const QString& mapType);
    static QString              getTypeFromName     (const QString& name);
    static QString              bigSizeToString     (quint64 size);
    static QString              storageFreeSizeToString(quint64 size_MB);
    static QString              numberToString      (quint64 number);
    static int                  concurrentDownloads (const QString& type);

private slots:
    void _updateTotals          (quint32 totaltiles, quint64 totalsize, quint32 defaulttiles, quint64 defaultsize);
    void _pruned                ();
    void _internetStatus        (bool active);

signals:
    void updateTotals           (quint32 totaltiles, quint64 totalsize, quint32 defaulttiles, quint64 defaultsize);
    void internetUpdated        ();

private:
    void _wipeOldCaches         ();
    void _checkWipeDirectory    (const QString& dirPath);
    bool _wipeDirectory         (const QString& dirPath);

private:
    QGCCacheWorker          _worker;
    QString                 _cachePath;
    QString                 _cacheFile;
    UrlFactory*             _urlFactory;
    QString                 _userAgent;
    bool                    _prunning;
    bool                    _cacheWasReset;
    bool                    _isInternetActive;
};

extern QGCMapEngine*    getQGCMapEngine();
extern void             destroyMapEngine();

#endif // QGC_MAP_ENGINE_H
