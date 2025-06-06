/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#pragma once

#include <QSettings>

#include <memory>

class LinkInterface;

/// Interface holding link specific settings.
class LinkConfiguration : public QObject
{
    Q_OBJECT

public:
    LinkConfiguration(const QString& name);
    LinkConfiguration(LinkConfiguration* copy);
    virtual ~LinkConfiguration() {}

    Q_PROPERTY(QString          name                READ name           WRITE setName           NOTIFY nameChanged)
    Q_PROPERTY(LinkInterface*   link                READ link                                   NOTIFY linkChanged)
    Q_PROPERTY(LinkType         linkType            READ type                                   CONSTANT)
    Q_PROPERTY(bool             dynamic             READ isDynamic      WRITE setDynamic        NOTIFY dynamicChanged)
    Q_PROPERTY(bool             autoConnect         READ isAutoConnect  WRITE setAutoConnect    NOTIFY autoConnectChanged)
    Q_PROPERTY(QString          settingsURL         READ settingsURL                            CONSTANT)
    Q_PROPERTY(QString          settingsTitle       READ settingsTitle                          CONSTANT)
    Q_PROPERTY(bool             highLatency         READ isHighLatency  WRITE setHighLatency    NOTIFY highLatencyChanged)

    // Property accessors

    QString         name(void) const { return _name; }
    LinkInterface*  link(void)  { return _link.lock().get(); }

    void            setName(const QString name);
    void            setLink(std::shared_ptr<LinkInterface> link);

    ///  The link types supported by QGC
    ///  Any changes here MUST be reflected in LinkManager::linkTypeStrings()
    enum LinkType {
#ifndef NO_SERIAL_LINK
        TypeSerial,     ///< Serial Link
#endif
        TypeUdp,        ///< UDP Link
        TypeTcp,        ///< TCP Link
#ifdef QGC_ENABLE_BLUETOOTH
        TypeBluetooth,  ///< Bluetooth Link
#endif
#ifdef QT_DEBUG
        TypeMock,       ///< Mock Link for Unitesting
#endif
#ifndef QGC_AIRLINK_DISABLED
        Airlink,
#endif
        TypeLogReplay,
        TypeLast        // Last type value (type >= TypeLast == invalid)
    };
    Q_ENUM(LinkType)

    bool isDynamic      () const{ return _dynamic; }     ///< Not persisted
    bool isAutoConnect  () const{ return _autoConnect; }

    /*!
     *
     * Is this a High Latency configuration?
     * @return True if this is an High Latency configuration (link with large delays).
     */
    bool isHighLatency() const{ return _highLatency; }

    /*!
     * Set if this is this a dynamic configuration. (decided at runtime)
    */
    void setDynamic(bool dynamic = true) { _dynamic = dynamic; emit dynamicChanged(); }

    /*!
     * Set if this is this an Auto Connect configuration.
    */
    void setAutoConnect(bool autoc = true) { _autoConnect = autoc; emit autoConnectChanged(); }

    /*!
     * Set if this is this an High Latency configuration.
    */
    void setHighLatency(bool hl = false) { _highLatency = hl; emit highLatencyChanged(); }

    /// Virtual Methods

    /*!
     * @brief Connection type
     *
     * Pure virtual method returning one of the -TypeXxx types above.
     * @return The type of links these settings belong to.
     */
    virtual LinkType type() = 0;

    /*!
     * @brief Load settings
     *
     * Pure virtual method telling the instance to load its configuration.
     * @param[in] settings The QSettings instance to use
     * @param[in] root The root path of the setting.
     */
    virtual void loadSettings(QSettings& settings, const QString& root) = 0;

    /*!
     * @brief Save settings
     *
     * Pure virtual method telling the instance to save its configuration.
     * @param[in] settings The QSettings instance to use
     * @param[in] root The root path of the setting.
     */
    virtual void saveSettings(QSettings& settings, const QString& root) = 0;

    /*!
     * @brief Settings URL
     *
     * Pure virtual method providing the URL for the (QML) settings dialog
     */
    virtual QString settingsURL     () = 0;

    /*!
     * @brief Settings Title
     *
     * Pure virtual method providing the Title for the (QML) settings dialog
     */
    virtual QString settingsTitle   () = 0;

    /*!
     * @brief Copy instance data
     *
     * When manipulating data, you create a copy of the configuration using the copy constructor,
     * edit it and then transfer its content to the original using this method.
     * @param[in] source The source instance (the edited copy)
     */
    virtual void copyFrom(LinkConfiguration* source);

    /// Helper static methods

    /*!
     * @brief Root path for QSettings
     *
     * @return The root path of the settings.
     */
    static const QString settingsRoot();

    /*!
     * @brief Create new link configuration instance
     *
     * Configuration Factory. Creates an appropriate configuration instance based on the given type.
     * @return A new instance of the given type
     */
    static LinkConfiguration* createSettings(int type, const QString& name);

    /*!
     * @brief Duplicate configuration instance
     *
     * Helper method to create a new instance copy for editing.
     * @return A new copy of the given settings instance
     */
    static LinkConfiguration* duplicateSettings(LinkConfiguration *source);

signals:
    void nameChanged        (const QString& name);
    void dynamicChanged     ();
    void autoConnectChanged ();
    void highLatencyChanged ();
    void linkChanged        ();

protected:
    std::weak_ptr<LinkInterface> _link; ///< Link currently using this configuration (if any)

private:
    QString _name;
    bool    _dynamic;       ///< A connection added automatically and not persistent (unless it's edited).
    bool    _autoConnect;   ///< This connection is started automatically at boot
    bool    _highLatency;
};

typedef std::shared_ptr<LinkConfiguration>  SharedLinkConfigurationPtr;
typedef std::weak_ptr<LinkConfiguration>    WeakLinkConfigurationPtr;

