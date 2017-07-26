Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:14917 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbdGZKBt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Jul 2017 06:01:49 -0400
Message-ID: <1501063301.29303.247.camel@linux.intel.com>
Subject: Re: [PATCH v1 3/6] staging: unisys: Switch to use new generic UUID
 API
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org, devel@linuxdriverproject.org,
        sparmaintainer@unisys.com, devel@driverdev.osuosl.org,
        linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-efi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Cc: David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 26 Jul 2017 13:01:41 +0300
In-Reply-To: <20170719182857.73693-4-andriy.shevchenko@linux.intel.com>
References: <20170719182857.73693-1-andriy.shevchenko@linux.intel.com>
         <20170719182857.73693-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-07-19 at 21:28 +0300, Andy Shevchenko wrote:
> There are new types and helpers that are supposed to be used in new
> code.
>=20
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
>=20
> While here, re-indent couple of lines to increase readability.

This looks like no user space UUID API is involved, can be routed via
either tree (uuid or staging).

Anyone to comment?

>=20
> Cc: David Kershner <david.kershner@unisys.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: sparmaintainer@unisys.com
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/staging/unisys/Documentation/overview.txt=C2=A0=C2=A0| 14=
 +++----
> =C2=A0drivers/staging/unisys/include/channel.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 45 ++++++++++---
> -------
> =C2=A0drivers/staging/unisys/include/iochannel.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 14 +------
> =C2=A0drivers/staging/unisys/include/visorbus.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 12 +++---
> =C2=A0drivers/staging/unisys/visorbus/controlvmchannel.h | 24 ++++-----=
--
> =C2=A0drivers/staging/unisys/visorbus/vbuschannel.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A07 ++--
> =C2=A0drivers/staging/unisys/visorbus/visorbus_main.c=C2=A0=C2=A0=C2=A0=
=C2=A0| 28 ++++++-------
> =C2=A0drivers/staging/unisys/visorbus/visorbus_private.h |=C2=A0=C2=A06=
 +--
> =C2=A0drivers/staging/unisys/visorbus/visorchannel.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 48 +++++++++++
> -----------
> =C2=A0drivers/staging/unisys/visorbus/visorchipset.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 39 ++++++++++---
> -----
> =C2=A0drivers/staging/unisys/visorhba/visorhba_main.c=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A06 +--
> =C2=A0drivers/staging/unisys/visorinput/visorinput.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 38 ++++++++-----
> ----
> =C2=A0drivers/staging/unisys/visornic/visornic_main.c=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A06 +--
> =C2=A013 files changed, 135 insertions(+), 152 deletions(-)
>=20
> diff --git a/drivers/staging/unisys/Documentation/overview.txt
> b/drivers/staging/unisys/Documentation/overview.txt
> index e0466bfada2f..9ab30af265a5 100644
> --- a/drivers/staging/unisys/Documentation/overview.txt
> +++ b/drivers/staging/unisys/Documentation/overview.txt
> @@ -221,7 +221,7 @@ The following files exist under
> /sys/devices/visorbus<x>/vbus<x>:dev<y>:
> =C2=A0
> =C2=A0The visorhba driver registers with visorbus as the function drive=
r to
> =C2=A0handle virtual scsi disk devices, specified using the
> -VISOR_VHBA_CHANNEL_UUID type in the visorbus_register_visor_driver()
> +VISOR_VHBA_CHANNEL_GUID type in the visorbus_register_visor_driver()
> =C2=A0call. visorhba uses scsi_add_host() to expose a Linux block devic=
e
> =C2=A0(e.g., /sys/block/) in the guest environment for each s-Par virtu=
al
> device.
> =C2=A0
> @@ -240,7 +240,7 @@ When compiled as a module, visorhba can be
> autoloaded by visorbus in
> =C2=A0standard udev/systemd environments, as it includes the modules.al=
ias
> =C2=A0definition:
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0"visorbus:"+VISOR_VHBA_CHANNEL_UUID_STR
> +=C2=A0=C2=A0=C2=A0=C2=A0"visorbus:"+VISOR_VHBA_CHANNEL_GUID_STR
> =C2=A0
> =C2=A0i.e.:
> =C2=A0
> @@ -252,7 +252,7 @@ i.e.:
> =C2=A0
> =C2=A0The visornic driver registers with visorbus as the function drive=
r to
> =C2=A0handle virtual network devices, specified using the
> -VISOR_VNIC_CHANNEL_UUID type in the visorbus_register_visor_driver()
> +VISOR_VNIC_CHANNEL_GUID type in the visorbus_register_visor_driver()
> =C2=A0call. visornic uses register_netdev() to expose a Linux device of
> class net
> =C2=A0(e.g., /sys/class/net/) in the guest environment for each s-Par
> virtual
> =C2=A0device.
> @@ -270,7 +270,7 @@ When compiled as a module, visornic can be
> autoloaded by visorbus in
> =C2=A0standard udev/systemd environments, as it includes the modules.al=
ias
> =C2=A0definition:
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0"visorbus:"+VISOR_VNIC_CHANNEL_UUID_STR
> +=C2=A0=C2=A0=C2=A0=C2=A0"visorbus:"+VISOR_VNIC_CHANNEL_GUID_STR
> =C2=A0
> =C2=A0i.e.:
> =C2=A0
> @@ -282,7 +282,7 @@ i.e.:
> =C2=A0
> =C2=A0The visorinput driver registers with visorbus as the function dri=
ver
> to
> =C2=A0handle human input devices, specified using the
> -VISOR_KEYBOARD_CHANNEL_UUID and VISOR_MOUSE_CHANNEL_UUID
> +VISOR_KEYBOARD_CHANNEL_GUID and VISOR_MOUSE_CHANNEL_GUID
> =C2=A0types in the visorbus_register_visor_driver() call. visorinput us=
es
> =C2=A0input_register_device() to expose devices of class input
> =C2=A0(e.g., /sys/class/input/) for virtual keyboard and virtual mouse
> devices.
> @@ -307,8 +307,8 @@ When compiled as a module, visorinput can be
> autoloaded by visorbus in
> =C2=A0standard udev/systemd environments, as it includes the modules.al=
ias
> =C2=A0definition:
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0"visorbus:"+VISOR_MOUSE_CHANNEL_UUID_STR
> -=C2=A0=C2=A0=C2=A0=C2=A0"visorbus:"+VISOR_KEYBOARD_CHANNEL_UUID_STR
> +=C2=A0=C2=A0=C2=A0=C2=A0"visorbus:"+VISOR_MOUSE_CHANNEL_GUID_STR
> +=C2=A0=C2=A0=C2=A0=C2=A0"visorbus:"+VISOR_KEYBOARD_CHANNEL_GUID_STR
> =C2=A0
> =C2=A0i.e.:
> =C2=A0
> diff --git a/drivers/staging/unisys/include/channel.h
> b/drivers/staging/unisys/include/channel.h
> index 692efcb38245..b09b1f55a6f1 100644
> --- a/drivers/staging/unisys/include/channel.h
> +++ b/drivers/staging/unisys/include/channel.h
> @@ -116,13 +116,13 @@ struct channel_header {
> =C2=A0	u32 header_size;	/* sizeof(struct channel_header) */
> =C2=A0	u64 size;		/* Total size of this channel in
> bytes */
> =C2=A0	u64 features;		/* Flags to modify behavior */
> -	uuid_le chtype;		/* Channel type: data, bus,
> control, etc. */
> +	guid_t chtype;		/* Channel type: data, bus,
> control, etc. */
> =C2=A0	u64 partition_handle;	/* ID of guest partition */
> =C2=A0	u64 handle;		/* Device number of this channel
> in client */
> =C2=A0	u64 ch_space_offset;	/* Offset in bytes to channel
> specific area */
> =C2=A0	u32 version_id;		/* struct channel_header
> Version ID */
> =C2=A0	u32 partition_index;	/* Index of guest partition */
> -	uuid_le zone_uuid;	/* Guid of Channel's zone */
> +	guid_t zone_guid;	/* Guid of Channel's zone */
> =C2=A0	u32 cli_str_offset;	/* offset from channel header to
> =C2=A0				=C2=A0* nul-terminated ClientString (0 if
> =C2=A0				=C2=A0* ClientString not present)
> @@ -205,25 +205,25 @@ struct signal_queue_header {
> =C2=A0 */
> =C2=A0static inline int
> =C2=A0visor_check_channel(struct channel_header *ch,
> -		=C2=A0=C2=A0=C2=A0=C2=A0uuid_le expected_uuid,
> +		=C2=A0=C2=A0=C2=A0=C2=A0const guid_t *expected_guid,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0char *chname,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0u64 expected_min_bytes,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0u32 expected_version,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0u64 expected_signature)
> =C2=A0{
> -	if (uuid_le_cmp(expected_uuid, NULL_UUID_LE) !=3D 0) {
> +	if (!guid_is_null(expected_guid)) {
> =C2=A0		/* caller wants us to verify type GUID */
> -		if (uuid_le_cmp(ch->chtype, expected_uuid) !=3D 0) {
> +		if (!guid_equal(&ch->chtype, expected_guid)) {
> =C2=A0			pr_err("Channel mismatch on channel=3D%s(%pUL)
> field=3Dtype expected=3D%pUL actual=3D%pUL\n",
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chname, &expected_uuid,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&expected_uuid, &ch->chty=
pe);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chname, expected_guid,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0expected_guid, &ch->chtyp=
e);
> =C2=A0			return 0;
> =C2=A0		}
> =C2=A0	}
> =C2=A0	if (expected_min_bytes > 0) {	/* verify channel size
> */
> =C2=A0		if (ch->size < expected_min_bytes) {
> =C2=A0			pr_err("Channel mismatch on channel=3D%s(%pUL)
> field=3Dsize expected=3D0x%-8.8Lx actual=3D0x%-8.8Lx\n",
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chname, &expected_uuid,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chname, expected_guid,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(unsigned long
> long)expected_min_bytes,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ch->size);
> =C2=A0			return 0;
> @@ -232,7 +232,7 @@ visor_check_channel(struct channel_header *ch,
> =C2=A0	if (expected_version > 0) {	/* verify channel version
> */
> =C2=A0		if (ch->version_id !=3D expected_version) {
> =C2=A0			pr_err("Channel mismatch on channel=3D%s(%pUL)
> field=3Dversion expected=3D0x%-8.8lx actual=3D0x%-8.8x\n",
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chname, &expected_uuid,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chname, expected_guid,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(unsigned long)expec=
ted_version,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ch->version_id);
> =C2=A0			return 0;
> @@ -241,7 +241,7 @@ visor_check_channel(struct channel_header *ch,
> =C2=A0	if (expected_signature > 0) {	/* verify channel
> signature */
> =C2=A0		if (ch->signature !=3D expected_signature) {
> =C2=A0			pr_err("Channel mismatch on channel=3D%s(%pUL)
> field=3Dsignature expected=3D0x%-8.8Lx actual=3D0x%-8.8Lx\n",
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chname, &expected_uuid,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chname, expected_guid,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0expected_signature, =
ch->signature);
> =C2=A0			return 0;
> =C2=A0		}
> @@ -254,25 +254,22 @@ visor_check_channel(struct channel_header *ch,
> =C2=A0 */
> =C2=A0
> =C2=A0/* {414815ed-c58c-11da-95a9-00e08161165f} */
> -#define VISOR_VHBA_CHANNEL_UUID \
> -	UUID_LE(0x414815ed, 0xc58c, 0x11da, \
> -		0x95, 0xa9, 0x0, 0xe0, 0x81, 0x61, 0x16, 0x5f)
> -static const uuid_le visor_vhba_channel_uuid =3D
> VISOR_VHBA_CHANNEL_UUID;
> -#define VISOR_VHBA_CHANNEL_UUID_STR \
> +#define VISOR_VHBA_CHANNEL_GUID \
> +	GUID_INIT(0x414815ed, 0xc58c, 0x11da, \
> +		=C2=A0=C2=A00x95, 0xa9, 0x0, 0xe0, 0x81, 0x61, 0x16, 0x5f)
> +#define VISOR_VHBA_CHANNEL_GUID_STR \
> =C2=A0	"414815ed-c58c-11da-95a9-00e08161165f"
> =C2=A0
> =C2=A0/* {8cd5994d-c58e-11da-95a9-00e08161165f} */
> -#define VISOR_VNIC_CHANNEL_UUID \
> -	UUID_LE(0x8cd5994d, 0xc58e, 0x11da, \
> -		0x95, 0xa9, 0x0, 0xe0, 0x81, 0x61, 0x16, 0x5f)
> -static const uuid_le visor_vnic_channel_uuid =3D
> VISOR_VNIC_CHANNEL_UUID;
> -#define VISOR_VNIC_CHANNEL_UUID_STR \
> +#define VISOR_VNIC_CHANNEL_GUID \
> +	GUID_INIT(0x8cd5994d, 0xc58e, 0x11da, \
> +		=C2=A0=C2=A00x95, 0xa9, 0x0, 0xe0, 0x81, 0x61, 0x16, 0x5f)
> +#define VISOR_VNIC_CHANNEL_GUID_STR \
> =C2=A0	"8cd5994d-c58e-11da-95a9-00e08161165f"
> =C2=A0
> =C2=A0/* {72120008-4AAB-11DC-8530-444553544200} */
> -#define VISOR_SIOVM_UUID \
> -	UUID_LE(0x72120008, 0x4AAB, 0x11DC, \
> -		0x85, 0x30, 0x44, 0x45, 0x53, 0x54, 0x42, 0x00)
> -static const uuid_le visor_siovm_uuid =3D VISOR_SIOVM_UUID;
> +#define VISOR_SIOVM_GUID \
> +	GUID_INIT(0x72120008, 0x4AAB, 0x11DC, \
> +		=C2=A0=C2=A00x85, 0x30, 0x44, 0x45, 0x53, 0x54, 0x42, 0x00)
> =C2=A0
> =C2=A0#endif
> diff --git a/drivers/staging/unisys/include/iochannel.h
> b/drivers/staging/unisys/include/iochannel.h
> index c7cb3fbde7b2..8f05bdd5197c 100644
> --- a/drivers/staging/unisys/include/iochannel.h
> +++ b/drivers/staging/unisys/include/iochannel.h
> @@ -49,18 +49,6 @@
> =C2=A0#define VISOR_VNIC_CHANNEL_VERSIONID 2
> =C2=A0#define VISOR_VSWITCH_CHANNEL_VERSIONID 1
> =C2=A0
> -#define VISOR_VHBA_CHANNEL_OK_CLIENT(ch) \
> -	(visor_check_channel(ch, visor_vhba_channel_uuid, \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"vhba", MIN_IO_CHANNEL_SIZE, \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VISOR_VHBA_CHANNEL_VERSIONID, \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VISOR_VHBA_CHANNEL_SIGNATURE))
> -
> -#define VISOR_VNIC_CHANNEL_OK_CLIENT(ch) \
> -	(visor_check_channel(ch, visor_vnic_channel_uuid, \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"vnic", MIN_IO_CHANNEL_SIZE, \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VISOR_VNIC_CHANNEL_VERSIONID, \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VISOR_VNIC_CHANNEL_SIGNATURE))
> -
> =C2=A0/*
> =C2=A0 * Everything necessary to handle SCSI & NIC traffic between Gues=
t
> Partition and
> =C2=A0 * IO Partition is defined below.
> @@ -522,7 +510,7 @@ struct iochannel_vnic {
> =C2=A0	u8 macaddr[6];			/* 6 bytes */
> =C2=A0	u32 num_rcv_bufs;		/* 4 bytes */
> =C2=A0	u32 mtu;			/* 4 bytes */
> -	uuid_le zone_uuid;		/* 16 bytes */
> +	guid_t zone_guid;		/* 16 bytes */
> =C2=A0} __packed;
> =C2=A0/*
> =C2=A0 * This is just the header of the IO channel. It is assumed that
> directly after
> diff --git a/drivers/staging/unisys/include/visorbus.h
> b/drivers/staging/unisys/include/visorbus.h
> index de0635542fbd..38ce0878c55e 100644
> --- a/drivers/staging/unisys/include/visorbus.h
> +++ b/drivers/staging/unisys/include/visorbus.h
> @@ -58,7 +58,7 @@ struct visorchipset_state {
> =C2=A0 *=C2=A0=C2=A0GUID, name, and sizes.
> =C2=A0 */
> =C2=A0struct visor_channeltype_descriptor {
> -	const uuid_le guid;
> +	const guid_t guid;
> =C2=A0	const char *name;
> =C2=A0};
> =C2=A0
> @@ -141,14 +141,14 @@ struct visor_driver {
> =C2=A0 *				hypervisor requests.
> =C2=A0 * @vbus_hdr_info:		A pointer to header info. Private
> use by bus
> =C2=A0 *				driver.
> - * @partition_uuid:		Indicates client partion id. This
> should be the
> + * @partition_guid:		Indicates client partion id. This
> should be the
> =C2=A0 *				same across all visor_devices in
> the current
> =C2=A0 *				guest. Private use by bus driver
> only.
> =C2=A0 */
> =C2=A0
> =C2=A0struct visor_device {
> =C2=A0	struct visorchannel *visorchannel;
> -	uuid_le channel_type_guid;
> +	guid_t channel_type_guid;
> =C2=A0	/* These fields are for private use by the bus driver only.
> */
> =C2=A0	struct device device;
> =C2=A0	struct list_head list_all;
> @@ -161,11 +161,11 @@ struct visor_device {
> =C2=A0	u32 chipset_bus_no;
> =C2=A0	u32 chipset_dev_no;
> =C2=A0	struct visorchipset_state state;
> -	uuid_le inst;
> +	guid_t inst;
> =C2=A0	u8 *name;
> =C2=A0	struct controlvm_message_header *pending_msg_hdr;
> =C2=A0	void *vbus_hdr_info;
> -	uuid_le partition_uuid;
> +	guid_t partition_guid;
> =C2=A0	struct dentry *debugfs_dir;
> =C2=A0	struct dentry *debugfs_client_bus_info;
> =C2=A0};
> @@ -207,7 +207,7 @@ int visorchannel_signalremove(struct visorchannel
> *channel, u32 queue,
> =C2=A0int visorchannel_signalinsert(struct visorchannel *channel, u32
> queue,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *msg);
> =C2=A0bool visorchannel_signalempty(struct visorchannel *channel, u32
> queue);
> -uuid_le visorchannel_get_uuid(struct visorchannel *channel);
> +const guid_t *visorchannel_get_guid(struct visorchannel *channel);
> =C2=A0
> =C2=A0#define BUS_ROOT_DEVICE UINT_MAX
> =C2=A0struct visor_device *visorbus_get_device_by_id(u32 bus_no, u32
> dev_no,
> diff --git a/drivers/staging/unisys/visorbus/controlvmchannel.h
> b/drivers/staging/unisys/visorbus/controlvmchannel.h
> index ed045eff0e33..d9d7628aff50 100644
> --- a/drivers/staging/unisys/visorbus/controlvmchannel.h
> +++ b/drivers/staging/unisys/visorbus/controlvmchannel.h
> @@ -19,9 +19,9 @@
> =C2=A0#include "channel.h"
> =C2=A0
> =C2=A0/* {2B3C2D10-7EF5-4ad8-B966-3448B7386B3D} */
> -#define VISOR_CONTROLVM_CHANNEL_UUID \
> -	UUID_LE(0x2b3c2d10, 0x7ef5, 0x4ad8, \
> -		0xb9, 0x66, 0x34, 0x48, 0xb7, 0x38, 0x6b, 0x3d)
> +#define VISOR_CONTROLVM_CHANNEL_GUID \
> +	GUID_INIT(0x2b3c2d10, 0x7ef5, 0x4ad8, \
> +		=C2=A0=C2=A00xb9, 0x66, 0x34, 0x48, 0xb7, 0x38, 0x6b, 0x3d)
> =C2=A0
> =C2=A0#define VISOR_CONTROLVM_CHANNEL_SIGNATURE VISOR_CHANNEL_SIGNATURE
> =C2=A0#define CONTROLVM_MESSAGE_MAX 64
> @@ -34,14 +34,6 @@
> =C2=A0 */
> =C2=A0#define VISOR_CONTROLVM_CHANNEL_VERSIONID 1
> =C2=A0
> -#define VISOR_CONTROLVM_CHANNEL_OK_CLIENT(ch) \
> -	(visor_check_channel(ch, \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VISOR_CONTROLVM_CHANNEL_UUID, \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"controlvm", \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sizeof(struct visor_controlvm_channel=
),
> \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VISOR_CONTROLVM_CHANNEL_VERSIONID, \
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VISOR_CONTROLVM_CHANNEL_SIGNATURE))
> -
> =C2=A0/* Defines for various channel queues */
> =C2=A0#define CONTROLVM_QUEUE_REQUEST	=C2=A00
> =C2=A0#define CONTROLVM_QUEUE_RESPONSE 1
> @@ -222,8 +214,8 @@ struct controlvm_packet_device_create=C2=A0=C2=A0{
> =C2=A0	=C2=A0*/
> =C2=A0	u64 channel_addr;
> =C2=A0	u64 channel_bytes;	/* specifies size of the channel in
> bytes */
> -	uuid_le data_type_uuid;	/* specifies format of data in
> channel */
> -	uuid_le dev_inst_uuid;	/* instance guid for the device
> */
> +	guid_t data_type_guid;	/* specifies format of data in
> channel */
> +	guid_t dev_inst_guid;	/* instance guid for the device
> */
> =C2=A0	struct irq_info intr;	/* specifies interrupt
> information */
> =C2=A0} __packed;	/* for CONTROLVM_DEVICE_CREATE */
> =C2=A0
> @@ -258,8 +250,8 @@ struct controlvm_message_packet=C2=A0=C2=A0{
> =C2=A0			u64 channel_addr;
> =C2=A0			u64 channel_bytes;	/* size of the
> channel */
> =C2=A0	/* indicates format of data in bus channel*/
> -			uuid_le bus_data_type_uuid;
> -			uuid_le bus_inst_uuid;	/* instance
> uuid for the bus */
> +			guid_t bus_data_type_guid;
> +			guid_t bus_inst_guid;	/* instance GUID
> for the bus */
> =C2=A0		} __packed create_bus;	/* for
> CONTROLVM_BUS_CREATE */
> =C2=A0		struct=C2=A0=C2=A0{
> =C2=A0	/* bus # (0..n-1) from the msg receiver's perspective */
> @@ -455,7 +447,7 @@ struct visor_controlvm_parameters_header {
> =C2=A0	u32 client_length;
> =C2=A0	u32 name_offset;
> =C2=A0	u32 name_length;
> -	uuid_le id;
> +	guid_t id;
> =C2=A0	u32 revision;
> =C2=A0	u32 reserved;		/* Natural alignment */
> =C2=A0} __packed;
> diff --git a/drivers/staging/unisys/visorbus/vbuschannel.h
> b/drivers/staging/unisys/visorbus/vbuschannel.h
> index 01d7d517dba7..8f256dbf7ad2 100644
> --- a/drivers/staging/unisys/visorbus/vbuschannel.h
> +++ b/drivers/staging/unisys/visorbus/vbuschannel.h
> @@ -27,10 +27,9 @@
> =C2=A0#include "channel.h"
> =C2=A0
> =C2=A0/* {193b331b-c58f-11da-95a9-00e08161165f} */
> -#define VISOR_VBUS_CHANNEL_UUID \
> -	UUID_LE(0x193b331b, 0xc58f, 0x11da, \
> -		0x95, 0xa9, 0x0, 0xe0, 0x81, 0x61, 0x16, 0x5f)
> -static const uuid_le visor_vbus_channel_uuid =3D
> VISOR_VBUS_CHANNEL_UUID;
> +#define VISOR_VBUS_CHANNEL_GUID \
> +	GUID_INIT(0x193b331b, 0xc58f, 0x11da, \
> +		=C2=A0=C2=A00x95, 0xa9, 0x0, 0xe0, 0x81, 0x61, 0x16, 0x5f)
> =C2=A0
> =C2=A0#define VISOR_VBUS_CHANNEL_SIGNATURE VISOR_CHANNEL_SIGNATURE
> =C2=A0
> diff --git a/drivers/staging/unisys/visorbus/visorbus_main.c
> b/drivers/staging/unisys/visorbus/visorbus_main.c
> index 1c785dd19ddd..dd932e39607b 100644
> --- a/drivers/staging/unisys/visorbus/visorbus_main.c
> +++ b/drivers/staging/unisys/visorbus/visorbus_main.c
> @@ -20,6 +20,8 @@
> =C2=A0#include "visorbus.h"
> =C2=A0#include "visorbus_private.h"
> =C2=A0
> +static const guid_t visor_vbus_channel_guid =3D
> VISOR_VBUS_CHANNEL_GUID;
> +
> =C2=A0#define MYDRVNAME "visorbus"
> =C2=A0
> =C2=A0/* Display string that is guaranteed to be no longer the 99
> characters*/
> @@ -40,11 +42,11 @@ static ssize_t modalias_show(struct device *dev,
> struct device_attribute *attr,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *buf)
> =C2=A0{
> =C2=A0	struct visor_device *vdev;
> -	uuid_le guid;
> +	const guid_t *guid;
> =C2=A0
> =C2=A0	vdev =3D to_visor_device(dev);
> -	guid =3D visorchannel_get_uuid(vdev->visorchannel);
> -	return sprintf(buf, "visorbus:%pUl\n", &guid);
> +	guid =3D visorchannel_get_guid(vdev->visorchannel);
> +	return sprintf(buf, "visorbus:%pUl\n", guid);
> =C2=A0}
> =C2=A0static DEVICE_ATTR_RO(modalias);
> =C2=A0
> @@ -77,12 +79,12 @@ static int
> =C2=A0visorbus_uevent(struct device *xdev, struct kobj_uevent_env *env)
> =C2=A0{
> =C2=A0	struct visor_device *dev;
> -	uuid_le guid;
> +	const guid_t *guid;
> =C2=A0
> =C2=A0	dev =3D to_visor_device(xdev);
> -	guid =3D visorchannel_get_uuid(dev->visorchannel);
> +	guid =3D visorchannel_get_guid(dev->visorchannel);
> =C2=A0
> -	return add_uevent_var(env, "MODALIAS=3Dvisorbus:%pUl", &guid);
> +	return add_uevent_var(env, "MODALIAS=3Dvisorbus:%pUl", guid);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -97,24 +99,22 @@ visorbus_uevent(struct device *xdev, struct
> kobj_uevent_env *env)
> =C2=A0static int
> =C2=A0visorbus_match(struct device *xdev, struct device_driver *xdrv)
> =C2=A0{
> -	uuid_le channel_type;
> +	const guid_t *channel_type;
> =C2=A0	int i;
> =C2=A0	struct visor_device *dev;
> =C2=A0	struct visor_driver *drv;
> =C2=A0
> =C2=A0	dev =3D to_visor_device(xdev);
> =C2=A0	drv =3D to_visor_driver(xdrv);
> -	channel_type =3D visorchannel_get_uuid(dev->visorchannel);
> +	channel_type =3D visorchannel_get_guid(dev->visorchannel);
> =C2=A0
> =C2=A0	if (!drv->channel_types)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	for (i =3D 0;
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(uuid_le_cmp(drv->channel_types[i].guid=
, NULL_UUID_LE)
> !=3D 0) ||
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(drv->channel_types[i].name);
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!guid_is_null(&drv->channel_types[i].gu=
id) || drv-
> >channel_types[i].name;
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i++)
> -		if (uuid_le_cmp(drv->channel_types[i].guid,
> -				channel_type) =3D=3D 0)
> +		if (guid_equal(&drv->channel_types[i].guid,
> channel_type))
> =C2=A0			return i + 1;
> =C2=A0
> =C2=A0	return 0;
> @@ -283,7 +283,7 @@ static ssize_t partition_guid_show(struct device
> *dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0char *buf) {
> =C2=A0	struct visor_device *vdev =3D to_visor_device(dev);
> =C2=A0
> -	return sprintf(buf, "{%pUb}\n", &vdev->partition_uuid);
> +	return sprintf(buf, "{%pUb}\n", &vdev->partition_guid);
> =C2=A0}
> =C2=A0static DEVICE_ATTR_RO(partition_guid);
> =C2=A0
> @@ -687,7 +687,7 @@ get_vbus_header_info(struct visorchannel *chan,
> =C2=A0	int err;
> =C2=A0
> =C2=A0	if (!visor_check_channel(visorchannel_get_header(chan),
> -				=C2=A0visor_vbus_channel_uuid,
> +				=C2=A0&visor_vbus_channel_guid,
> =C2=A0				=C2=A0"vbus",
> =C2=A0				=C2=A0sizeof(struct visor_vbus_channel),
> =C2=A0				=C2=A0VISOR_VBUS_CHANNEL_VERSIONID,
> diff --git a/drivers/staging/unisys/visorbus/visorbus_private.h
> b/drivers/staging/unisys/visorbus/visorbus_private.h
> index 98a5af19189d..0856179338df 100644
> --- a/drivers/staging/unisys/visorbus/visorbus_private.h
> +++ b/drivers/staging/unisys/visorbus/visorbus_private.h
> @@ -48,10 +48,10 @@ void visorbus_exit(void);
> =C2=A0
> =C2=A0struct visorchannel *visorchannel_create(u64 physaddr,
> =C2=A0					=C2=A0unsigned long channel_bytes,
> -					=C2=A0gfp_t gfp, uuid_le guid);
> +					=C2=A0gfp_t gfp, const guid_t
> *guid);
> =C2=A0struct visorchannel *visorchannel_create_with_lock(u64 physaddr,
> =C2=A0						=C2=A0=C2=A0=C2=A0unsigned long
> channel_bytes,
> -						=C2=A0=C2=A0=C2=A0gfp_t gfp, uuid_le
> guid);
> +						=C2=A0=C2=A0=C2=A0gfp_t gfp, const
> guid_t *guid);
> =C2=A0void visorchannel_destroy(struct visorchannel *channel);
> =C2=A0int visorchannel_read(struct visorchannel *channel, ulong offset,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *dest, ulong nbytes);
> @@ -64,6 +64,6 @@ char *visorchannel_zoneid(struct visorchannel
> *channel, char *s);
> =C2=A0u64 visorchannel_get_clientpartition(struct visorchannel *channel=
);
> =C2=A0int visorchannel_set_clientpartition(struct visorchannel *channel=
,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 partition_handle);
> -char *visorchannel_uuid_id(uuid_le *guid, char *s);
> +char *visorchannel_guid_id(const guid_t *guid, char *s);
> =C2=A0void *visorchannel_get_header(struct visorchannel *channel);
> =C2=A0#endif
> diff --git a/drivers/staging/unisys/visorbus/visorchannel.c
> b/drivers/staging/unisys/visorbus/visorchannel.c
> index 6885c2cb7135..fd64be952628 100644
> --- a/drivers/staging/unisys/visorbus/visorchannel.c
> +++ b/drivers/staging/unisys/visorbus/visorchannel.c
> @@ -29,10 +29,10 @@
> =C2=A0#define MYDRVNAME "visorchannel"
> =C2=A0
> =C2=A0#define VISOR_CONSOLEVIDEO_CHANNEL_GUID \
> -	UUID_LE(0x3cd6e705, 0xd6a2, 0x4aa5, \
> -		0xad, 0x5c, 0x7b, 0x8, 0x88, 0x9d, 0xff, 0xe2)
> +	GUID_INIT(0x3cd6e705, 0xd6a2, 0x4aa5, \
> +		=C2=A0=C2=A00xad, 0x5c, 0x7b, 0x8, 0x88, 0x9d, 0xff, 0xe2)
> =C2=A0
> -static const uuid_le visor_video_guid =3D
> VISOR_CONSOLEVIDEO_CHANNEL_GUID;
> +static const guid_t visor_video_guid =3D
> VISOR_CONSOLEVIDEO_CHANNEL_GUID;
> =C2=A0
> =C2=A0struct visorchannel {
> =C2=A0	u64 physaddr;
> @@ -40,14 +40,14 @@ struct visorchannel {
> =C2=A0	void *mapped;
> =C2=A0	bool requested;
> =C2=A0	struct channel_header chan_hdr;
> -	uuid_le guid;
> +	guid_t guid;
> =C2=A0	bool needs_lock;	/* channel creator knows if more than
> one */
> =C2=A0				/* thread will be inserting or
> removing */
> =C2=A0	spinlock_t insert_lock; /* protect head writes in chan_hdr */
> =C2=A0	spinlock_t remove_lock;	/* protect tail writes in
> chan_hdr */
> =C2=A0
> -	uuid_le type;
> -	uuid_le inst;
> +	guid_t type;
> +	guid_t inst;
> =C2=A0};
> =C2=A0
> =C2=A0void
> @@ -76,7 +76,7 @@ visorchannel_get_nbytes(struct visorchannel
> *channel)
> =C2=A0}
> =C2=A0
> =C2=A0char *
> -visorchannel_uuid_id(uuid_le *guid, char *s)
> +visorchannel_guid_id(const guid_t *guid, char *s)
> =C2=A0{
> =C2=A0	sprintf(s, "%pUL", guid);
> =C2=A0	return s;
> @@ -85,13 +85,13 @@ visorchannel_uuid_id(uuid_le *guid, char *s)
> =C2=A0char *
> =C2=A0visorchannel_id(struct visorchannel *channel, char *s)
> =C2=A0{
> -	return visorchannel_uuid_id(&channel->guid, s);
> +	return visorchannel_guid_id(&channel->guid, s);
> =C2=A0}
> =C2=A0
> =C2=A0char *
> =C2=A0visorchannel_zoneid(struct visorchannel *channel, char *s)
> =C2=A0{
> -	return visorchannel_uuid_id(&channel->chan_hdr.zone_uuid, s);
> +	return visorchannel_guid_id(&channel->chan_hdr.zone_guid, s);
> =C2=A0}
> =C2=A0
> =C2=A0u64
> @@ -109,17 +109,17 @@ visorchannel_set_clientpartition(struct
> visorchannel *channel,
> =C2=A0}
> =C2=A0
> =C2=A0/**
> - * visorchannel_get_uuid() - queries the UUID of the designated
> channel
> + * visorchannel_get_guid() - queries the GUID of the designated
> channel
> =C2=A0 * @channel: the channel to query
> =C2=A0 *
> - * Return: the UUID of the provided channel
> + * Return: the GUID of the provided channel
> =C2=A0 */
> -uuid_le
> -visorchannel_get_uuid(struct visorchannel *channel)
> +const guid_t *
> +visorchannel_get_guid(struct visorchannel *channel)
> =C2=A0{
> -	return channel->guid;
> +	return &channel->guid;
> =C2=A0}
> -EXPORT_SYMBOL_GPL(visorchannel_get_uuid);
> +EXPORT_SYMBOL_GPL(visorchannel_get_guid);
> =C2=A0
> =C2=A0int
> =C2=A0visorchannel_read(struct visorchannel *channel, ulong offset,
> @@ -376,7 +376,7 @@ signalinsert_inner(struct visorchannel *channel,
> u32 queue, void *msg)
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0back-end), in which case the actua=
l channel size
> will be
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read from the channel header in me=
mory
> =C2=A0 * @gfp:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0gfp_t to use when allocating memory for the data
> struct
> - * @guid:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u=
uid that identifies channel type; this may 0 if
> the channel
> + * @guid:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0G=
UID that identifies channel type; this may 0 if
> the channel
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0has already been initialized in me=
mory (which is
> true for all
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels provided to guest environ=
ments by the s-
> Par
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0back-end), in which case the actua=
l channel guid
> will be
> @@ -390,7 +390,7 @@ signalinsert_inner(struct visorchannel *channel,
> u32 queue, void *msg)
> =C2=A0 */
> =C2=A0static struct visorchannel *
> =C2=A0visorchannel_create_guts(u64 physaddr, unsigned long channel_byte=
s,
> -			=C2=A0gfp_t gfp, uuid_le guid, bool needs_lock)
> +			=C2=A0gfp_t gfp, const guid_t *guid, bool
> needs_lock)
> =C2=A0{
> =C2=A0	struct visorchannel *channel;
> =C2=A0	int err;
> @@ -415,7 +415,7 @@ visorchannel_create_guts(u64 physaddr, unsigned
> long channel_bytes,
> =C2=A0	=C2=A0* release later on.
> =C2=A0	=C2=A0*/
> =C2=A0	channel->requested =3D request_mem_region(physaddr, size,
> MYDRVNAME);
> -	if (!channel->requested && uuid_le_cmp(guid,
> visor_video_guid))
> +	if (!channel->requested && !guid_equal(guid,
> &visor_video_guid))
> =C2=A0		/* we only care about errors if this is not the video
> channel */
> =C2=A0		goto err_destroy_channel;
> =C2=A0
> @@ -436,8 +436,8 @@ visorchannel_create_guts(u64 physaddr, unsigned
> long channel_bytes,
> =C2=A0	/* we had better be a CLIENT of this channel */
> =C2=A0	if (channel_bytes =3D=3D 0)
> =C2=A0		channel_bytes =3D (ulong)channel->chan_hdr.size;
> -	if (uuid_le_cmp(guid, NULL_UUID_LE) =3D=3D 0)
> -		guid =3D channel->chan_hdr.chtype;
> +	if (guid_is_null(guid))
> +		guid =3D &channel->chan_hdr.chtype;
> =C2=A0
> =C2=A0	memunmap(channel->mapped);
> =C2=A0	if (channel->requested)
> @@ -445,7 +445,7 @@ visorchannel_create_guts(u64 physaddr, unsigned
> long channel_bytes,
> =C2=A0	channel->mapped =3D NULL;
> =C2=A0	channel->requested =3D request_mem_region(channel->physaddr,
> =C2=A0						channel_bytes,
> MYDRVNAME);
> -	if (!channel->requested && uuid_le_cmp(guid,
> visor_video_guid))
> +	if (!channel->requested && !guid_equal(guid,
> &visor_video_guid))
> =C2=A0		/* we only care about errors if this is not the video
> channel */
> =C2=A0		goto err_destroy_channel;
> =C2=A0
> @@ -457,7 +457,7 @@ visorchannel_create_guts(u64 physaddr, unsigned
> long channel_bytes,
> =C2=A0	}
> =C2=A0
> =C2=A0	channel->nbytes =3D channel_bytes;
> -	channel->guid =3D guid;
> +	guid_copy(&channel->guid, guid);
> =C2=A0	return channel;
> =C2=A0
> =C2=A0err_destroy_channel:
> @@ -467,7 +467,7 @@ visorchannel_create_guts(u64 physaddr, unsigned
> long channel_bytes,
> =C2=A0
> =C2=A0struct visorchannel *
> =C2=A0visorchannel_create(u64 physaddr, unsigned long channel_bytes,
> -		=C2=A0=C2=A0=C2=A0=C2=A0gfp_t gfp, uuid_le guid)
> +		=C2=A0=C2=A0=C2=A0=C2=A0gfp_t gfp, const guid_t *guid)
> =C2=A0{
> =C2=A0	return visorchannel_create_guts(physaddr, channel_bytes, gfp,
> guid,
> =C2=A0					false);
> @@ -475,7 +475,7 @@ visorchannel_create(u64 physaddr, unsigned long
> channel_bytes,
> =C2=A0
> =C2=A0struct visorchannel *
> =C2=A0visorchannel_create_with_lock(u64 physaddr, unsigned long
> channel_bytes,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gfp_t gfp, uuid_le guid)
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gfp_t gfp, const guid_t *guid)
> =C2=A0{
> =C2=A0	return visorchannel_create_guts(physaddr, channel_bytes, gfp,
> guid,
> =C2=A0					true);
> diff --git a/drivers/staging/unisys/visorbus/visorchipset.c
> b/drivers/staging/unisys/visorbus/visorchipset.c
> index 22150564b4fb..5e2bb9b8fa1b 100644
> --- a/drivers/staging/unisys/visorbus/visorchipset.c
> +++ b/drivers/staging/unisys/visorbus/visorchipset.c
> @@ -27,6 +27,10 @@
> =C2=A0#include "visorbus_private.h"
> =C2=A0#include "vmcallinterface.h"
> =C2=A0
> +static const guid_t visor_vhba_channel_guid =3D
> VISOR_VHBA_CHANNEL_GUID;
> +static const guid_t visor_siovm_guid =3D VISOR_SIOVM_GUID;
> +static const guid_t visor_controlvm_channel_guid =3D
> VISOR_CONTROLVM_CHANNEL_GUID;
> +
> =C2=A0#define CURRENT_FILE_PC VISOR_BUS_PC_visorchipset_c
> =C2=A0
> =C2=A0#define POLLJIFFIES_CONTROLVMCHANNEL_FAST 1
> @@ -277,13 +281,12 @@ static ssize_t remaining_steps_store(struct
> device *dev,
> =C2=A0}
> =C2=A0static DEVICE_ATTR_RW(remaining_steps);
> =C2=A0
> -static uuid_le
> -parser_id_get(struct parser_context *ctx)
> +static const guid_t *parser_id_get(struct parser_context *ctx)
> =C2=A0{
> =C2=A0	struct visor_controlvm_parameters_header *phdr =3D NULL;
> =C2=A0
> =C2=A0	phdr =3D (struct visor_controlvm_parameters_header *)(ctx-
> >data);
> -	return phdr->id;
> +	return &phdr->id;
> =C2=A0}
> =C2=A0
> =C2=A0static void parser_done(struct parser_context *ctx)
> @@ -595,7 +598,7 @@ visorbus_create(struct controlvm_message *inmsg)
> =C2=A0	bus_info->chipset_bus_no =3D bus_no;
> =C2=A0	bus_info->chipset_dev_no =3D BUS_ROOT_DEVICE;
> =C2=A0
> -	if (uuid_le_cmp(cmd->create_bus.bus_inst_uuid,
> visor_siovm_uuid) =3D=3D 0) {
> +	if (guid_equal(&cmd->create_bus.bus_inst_guid,
> &visor_siovm_guid)) {
> =C2=A0		err =3D save_crash_message(inmsg, CRASH_BUS);
> =C2=A0		if (err)
> =C2=A0			goto err_free_bus_info;
> @@ -617,7 +620,7 @@ visorbus_create(struct controlvm_message *inmsg)
> =C2=A0	visorchannel =3D visorchannel_create(cmd-
> >create_bus.channel_addr,
> =C2=A0					=C2=A0=C2=A0=C2=A0cmd-
> >create_bus.channel_bytes,
> =C2=A0					=C2=A0=C2=A0=C2=A0GFP_KERNEL,
> -					=C2=A0=C2=A0=C2=A0cmd-
> >create_bus.bus_data_type_uuid);
> +					=C2=A0=C2=A0=C2=A0&cmd-
> >create_bus.bus_data_type_guid);
> =C2=A0
> =C2=A0	if (!visorchannel) {
> =C2=A0		err =3D -ENOMEM;
> @@ -722,7 +725,9 @@ visorbus_configure(struct controlvm_message
> *inmsg,
> =C2=A0		goto err_respond;
> =C2=A0
> =C2=A0	if (parser_ctx) {
> -		bus_info->partition_uuid =3D parser_id_get(parser_ctx);
> +		const guid_t *partition_guid =3D
> parser_id_get(parser_ctx);
> +
> +		guid_copy(&bus_info->partition_guid, partition_guid);
> =C2=A0		bus_info->name =3D parser_name_get(parser_ctx);
> =C2=A0	}
> =C2=A0
> @@ -781,7 +786,7 @@ visorbus_device_create(struct controlvm_message
> *inmsg)
> =C2=A0
> =C2=A0	dev_info->chipset_bus_no =3D bus_no;
> =C2=A0	dev_info->chipset_dev_no =3D dev_no;
> -	dev_info->inst =3D cmd->create_device.dev_inst_uuid;
> +	guid_copy(&dev_info->inst, &cmd-
> >create_device.dev_inst_guid);
> =C2=A0
> =C2=A0	/* not sure where the best place to set the 'parent' */
> =C2=A0	dev_info->device.parent =3D &bus_info->device;
> @@ -790,7 +795,7 @@ visorbus_device_create(struct controlvm_message
> *inmsg)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0visorchannel_create_wi=
th_lock(cmd-
> >create_device.channel_addr,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd-
> >create_device.channel_bytes,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GFP_KERNEL,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd-
> >create_device.data_type_uuid);
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&cmd-
> >create_device.data_type_guid);
> =C2=A0
> =C2=A0	if (!visorchannel) {
> =C2=A0		dev_err(&chipset_dev->acpi_device->dev,
> @@ -800,9 +805,8 @@ visorbus_device_create(struct controlvm_message
> *inmsg)
> =C2=A0		goto err_free_dev_info;
> =C2=A0	}
> =C2=A0	dev_info->visorchannel =3D visorchannel;
> -	dev_info->channel_type_guid =3D cmd-
> >create_device.data_type_uuid;
> -	if (uuid_le_cmp(cmd->create_device.data_type_uuid,
> -			visor_vhba_channel_uuid) =3D=3D 0) {
> +	guid_copy(&dev_info->channel_type_guid, &cmd-
> >create_device.data_type_guid);
> +	if (guid_equal(&cmd->create_device.data_type_guid,
> &visor_vhba_channel_guid)) {
> =C2=A0		err =3D save_crash_message(inmsg, CRASH_DEV);
> =C2=A0		if (err)
> =C2=A0			goto err_destroy_visorchannel;
> @@ -1817,7 +1821,6 @@ visorchipset_init(struct acpi_device
> *acpi_device)
> =C2=A0{
> =C2=A0	int err =3D -ENODEV;
> =C2=A0	u64 addr;
> -	uuid_le uuid =3D VISOR_CONTROLVM_CHANNEL_UUID;
> =C2=A0	struct visorchannel *controlvm_channel;
> =C2=A0
> =C2=A0	chipset_dev =3D kzalloc(sizeof(*chipset_dev), GFP_KERNEL);
> @@ -1832,9 +1835,9 @@ visorchipset_init(struct acpi_device
> *acpi_device)
> =C2=A0
> =C2=A0	chipset_dev->acpi_device =3D acpi_device;
> =C2=A0	chipset_dev->poll_jiffies =3D
> POLLJIFFIES_CONTROLVMCHANNEL_FAST;
> -	controlvm_channel =3D visorchannel_create_with_lock(addr,
> -							=C2=A0=C2=A00,
> GFP_KERNEL, uuid);
> =C2=A0
> +	controlvm_channel =3D visorchannel_create_with_lock(addr, 0,
> GFP_KERNEL,
> +						&visor_controlvm_chan
> nel_guid);
> =C2=A0	if (!controlvm_channel)
> =C2=A0		goto error_free_chipset_dev;
> =C2=A0
> @@ -1845,8 +1848,12 @@ visorchipset_init(struct acpi_device
> *acpi_device)
> =C2=A0	if (err < 0)
> =C2=A0		goto error_destroy_channel;
> =C2=A0
> -	if (!VISOR_CONTROLVM_CHANNEL_OK_CLIENT(
> -				visorchannel_get_header(controlvm_cha
> nnel)))
> +	if
> (!visor_check_channel(visorchannel_get_header(controlvm_channel),
> +				=C2=A0&visor_controlvm_channel_guid,
> +				=C2=A0"controlvm",
> +				=C2=A0sizeof(struct
> visor_controlvm_channel),
> +				=C2=A0VISOR_CONTROLVM_CHANNEL_VERSIONID,
> +				=C2=A0VISOR_CONTROLVM_CHANNEL_SIGNATURE))
> =C2=A0		goto error_delete_groups;
> =C2=A0
> =C2=A0	/* if booting in a crash kernel */
> diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c
> b/drivers/staging/unisys/visorhba/visorhba_main.c
> index a6e7a6bbc428..d0e84ca08a5a 100644
> --- a/drivers/staging/unisys/visorhba/visorhba_main.c
> +++ b/drivers/staging/unisys/visorhba/visorhba_main.c
> @@ -39,12 +39,12 @@ static struct visor_channeltype_descriptor
> visorhba_channel_types[] =3D {
> =C2=A0	/* Note that the only channel type we expect to be reported
> by the
> =C2=A0	=C2=A0* bus driver is the VISOR_VHBA channel.
> =C2=A0	=C2=A0*/
> -	{ VISOR_VHBA_CHANNEL_UUID, "sparvhba" },
> -	{ NULL_UUID_LE, NULL }
> +	{ VISOR_VHBA_CHANNEL_GUID, "sparvhba" },
> +	{}
> =C2=A0};
> =C2=A0
> =C2=A0MODULE_DEVICE_TABLE(visorbus, visorhba_channel_types);
> -MODULE_ALIAS("visorbus:" VISOR_VHBA_CHANNEL_UUID_STR);
> +MODULE_ALIAS("visorbus:" VISOR_VHBA_CHANNEL_GUID_STR);
> =C2=A0
> =C2=A0struct visordisk_info {
> =C2=A0	u32 valid;
> diff --git a/drivers/staging/unisys/visorinput/visorinput.c
> b/drivers/staging/unisys/visorinput/visorinput.c
> index 45bc340d4e9d..fbf4957ffa15 100644
> --- a/drivers/staging/unisys/visorinput/visorinput.c
> +++ b/drivers/staging/unisys/visorinput/visorinput.c
> @@ -33,16 +33,16 @@
> =C2=A0#include "ultrainputreport.h"
> =C2=A0
> =C2=A0/* Keyboard channel {c73416d0-b0b8-44af-b304-9d2ae99f1b3d} */
> -#define VISOR_KEYBOARD_CHANNEL_UUID \
> -	UUID_LE(0xc73416d0, 0xb0b8, 0x44af, \
> -		0xb3, 0x4, 0x9d, 0x2a, 0xe9, 0x9f, 0x1b, 0x3d)
> -#define VISOR_KEYBOARD_CHANNEL_UUID_STR "c73416d0-b0b8-44af-b304-
> 9d2ae99f1b3d"
> +#define VISOR_KEYBOARD_CHANNEL_GUID \
> +	GUID_INIT(0xc73416d0, 0xb0b8, 0x44af, \
> +		=C2=A0=C2=A00xb3, 0x4, 0x9d, 0x2a, 0xe9, 0x9f, 0x1b, 0x3d)
> +#define VISOR_KEYBOARD_CHANNEL_GUID_STR "c73416d0-b0b8-44af-b304-
> 9d2ae99f1b3d"
> =C2=A0
> =C2=A0/* Mouse channel {addf07d4-94a9-46e2-81c3-61abcdbdbd87} */
> -#define VISOR_MOUSE_CHANNEL_UUID \
> -	UUID_LE(0xaddf07d4, 0x94a9, 0x46e2, \
> -		0x81, 0xc3, 0x61, 0xab, 0xcd, 0xbd, 0xbd, 0x87)
> -#define VISOR_MOUSE_CHANNEL_UUID_STR "addf07d4-94a9-46e2-81c3-
> 61abcdbdbd87"
> +#define VISOR_MOUSE_CHANNEL_GUID \
> +	GUID_INIT(0xaddf07d4, 0x94a9, 0x46e2, \
> +		=C2=A0=C2=A00x81, 0xc3, 0x61, 0xab, 0xcd, 0xbd, 0xbd, 0x87)
> +#define VISOR_MOUSE_CHANNEL_GUID_STR "addf07d4-94a9-46e2-81c3-
> 61abcdbdbd87"
> =C2=A0
> =C2=A0#define PIXELS_ACROSS_DEFAULT 800
> =C2=A0#define PIXELS_DOWN_DEFAULT=C2=A0=C2=A0=C2=A0600
> @@ -69,8 +69,8 @@ struct visorinput_devdata {
> =C2=A0	unsigned char keycode_table[0];
> =C2=A0};
> =C2=A0
> -static const uuid_le visor_keyboard_channel_uuid =3D
> VISOR_KEYBOARD_CHANNEL_UUID;
> -static const uuid_le visor_mouse_channel_uuid =3D
> VISOR_MOUSE_CHANNEL_UUID;
> +static const guid_t visor_keyboard_channel_guid =3D
> VISOR_KEYBOARD_CHANNEL_GUID;
> +static const guid_t visor_mouse_channel_guid =3D
> VISOR_MOUSE_CHANNEL_GUID;
> =C2=A0
> =C2=A0/*
> =C2=A0 * Borrowed from drivers/input/keyboard/atakbd.c
> @@ -449,13 +449,13 @@ devdata_create(struct visor_device *dev, enum
> visorinput_device_type devtype)
> =C2=A0static int
> =C2=A0visorinput_probe(struct visor_device *dev)
> =C2=A0{
> -	uuid_le guid;
> +	const guid_t *guid;
> =C2=A0	enum visorinput_device_type devtype;
> =C2=A0
> -	guid =3D visorchannel_get_uuid(dev->visorchannel);
> -	if (uuid_le_cmp(guid, visor_mouse_channel_uuid) =3D=3D 0)
> +	guid =3D visorchannel_get_guid(dev->visorchannel);
> +	if (guid_equal(guid, &visor_mouse_channel_guid))
> =C2=A0		devtype =3D visorinput_mouse;
> -	else if (uuid_le_cmp(guid, visor_keyboard_channel_uuid) =3D=3D 0)
> +	else if (guid_equal(guid, &visor_keyboard_channel_guid))
> =C2=A0		devtype =3D visorinput_keyboard;
> =C2=A0	else
> =C2=A0		return -ENODEV;
> @@ -727,9 +727,9 @@ visorinput_resume(struct visor_device *dev,
> =C2=A0
> =C2=A0/* GUIDS for all channel types supported by this driver. */
> =C2=A0static struct visor_channeltype_descriptor visorinput_channel_typ=
es[]
> =3D {
> -	{ VISOR_KEYBOARD_CHANNEL_UUID, "keyboard"},
> -	{ VISOR_MOUSE_CHANNEL_UUID, "mouse"},
> -	{ NULL_UUID_LE, NULL }
> +	{ VISOR_KEYBOARD_CHANNEL_GUID, "keyboard"},
> +	{ VISOR_MOUSE_CHANNEL_GUID, "mouse"},
> +	{}
> =C2=A0};
> =C2=A0
> =C2=A0static struct visor_driver visorinput_driver =3D {
> @@ -764,5 +764,5 @@ MODULE_AUTHOR("Unisys");
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_DESCRIPTION("s-Par human input driver for virtual
> keyboard/mouse");
> =C2=A0
> -MODULE_ALIAS("visorbus:" VISOR_MOUSE_CHANNEL_UUID_STR);
> -MODULE_ALIAS("visorbus:" VISOR_KEYBOARD_CHANNEL_UUID_STR);
> +MODULE_ALIAS("visorbus:" VISOR_MOUSE_CHANNEL_GUID_STR);
> +MODULE_ALIAS("visorbus:" VISOR_KEYBOARD_CHANNEL_GUID_STR);
> diff --git a/drivers/staging/unisys/visornic/visornic_main.c
> b/drivers/staging/unisys/visornic/visornic_main.c
> index 2891622eef18..10c1d036f996 100644
> --- a/drivers/staging/unisys/visornic/visornic_main.c
> +++ b/drivers/staging/unisys/visornic/visornic_main.c
> @@ -41,8 +41,8 @@ static struct visor_channeltype_descriptor
> visornic_channel_types[] =3D {
> =C2=A0	/* Note that the only channel type we expect to be reported
> by the
> =C2=A0	=C2=A0* bus driver is the VISOR_VNIC channel.
> =C2=A0	=C2=A0*/
> -	{ VISOR_VNIC_CHANNEL_UUID, "ultravnic" },
> -	{ NULL_UUID_LE, NULL }
> +	{ VISOR_VNIC_CHANNEL_GUID, "ultravnic" },
> +	{}
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(visorbus, visornic_channel_types);
> =C2=A0/*
> @@ -52,7 +52,7 @@ MODULE_DEVICE_TABLE(visorbus,
> visornic_channel_types);
> =C2=A0 * must be added to scripts/mode/file2alias.c, etc., to get this
> working
> =C2=A0 * properly.
> =C2=A0 */
> -MODULE_ALIAS("visorbus:" VISOR_VNIC_CHANNEL_UUID_STR);
> +MODULE_ALIAS("visorbus:" VISOR_VNIC_CHANNEL_GUID_STR);
> =C2=A0
> =C2=A0struct chanstat {
> =C2=A0	unsigned long got_rcv;

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
