Return-path: <francois-nicolas.muller@intel.com>
From: "Muller, Francois-nicolas" <francois-nicolas.muller@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Darren Hart <dvhart@infradead.org>,
	"'platform-driver-x86@vger.kernel.org'"
	<platform-driver-x86@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>,
	Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "Wim Van
 Sebroeck" <wim@iguana.be>
Subject: RE: [PATCH] TCO Watchdog warning interrupt driver creation
Date: Thu, 15 Jan 2015 13:27:22 +0000
Message-ID: <B9C02DB17496AC4197F41A146D371B9B075D41C0@hasmsx107.ger.corp.intel.com>
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com>
 <20141211040404.GA28797@vmdeb7> <5489AA6B.9080802@roeck-us.net>
 <B9C02DB17496AC4197F41A146D371B9B075C5FE3@hasmsx107.ger.corp.intel.com>
 <E73BFCB9-87CB-447D-839C-9ED4031FC6E2@infradead.org>
 <B9C02DB17496AC4197F41A146D371B9B075C6189@hasmsx107.ger.corp.intel.com>
 <54AF6288.6040305@roeck-us.net>
 <B9C02DB17496AC4197F41A146D371B9B075CC9FA@hasmsx107.ger.corp.intel.com>
 <20150114181657.GB13907@roeck-us.net>
In-Reply-To: <20150114181657.GB13907@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

TCO driver is anyway auto-loaded by mfd driver lpc_ich as a sub-function of=
 it.

The aim of my patch is only to add warning interrupt support in TCO driver.
For this it need the GPE number which is exposed by Bios in acpi tables.
So the patch registers also the TCO driver as an acpi driver to be able to =
retrieve this value.

The acpi code part is only required by the interrupt handling support, not =
needed for the loading of the driver itself (already done by lpc_ich).

In this context I don't see the point of dissociating the driver part from =
the loading, unless the loading would need to be reverted later.

Thanks,
Fran=E7ois-Nicolas

-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net]=20
Sent: Wednesday, January 14, 2015 7:17 PM
To: Muller, Francois-nicolas
Cc: Darren Hart; 'platform-driver-x86@vger.kernel.org'; Rafael Wysocki; Lin=
ux ACPI Mailing List; linux-watchdog@vger.kernel.org; Wim Van Sebroeck
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation

On Wed, Jan 14, 2015 at 04:32:33PM +0000, Muller, Francois-nicolas wrote:
> Thanks for your review, my comments embedded below.
> I'm sending the new version of the patch in the following email.
> Fran=E7ois-Nicolas
>=20
...
> >>
> >> +static const struct acpi_device_id iTCO_wdt_ids[] =3D {
> >> +	{"8086229C", 0},
> >> +	{"", 0},
> >> +};
> >> +MODULE_DEVICE_TABLE(acpi, iTCO_wdt_ids);
> >> +
> >
> >Doesn't that result in auto-loading the driver ?
>=20
> The driver is loaded only when Bios exposes the acpi device and the boot =
param warn_irq is true.
> Could you clarify ? I don't understand the issue.=20
>=20
Unless I am missing something, you are making two changes in a single patch=
.

- auto-load driver if acpi device is exposed by bios
- Add interrupt handling support

I suggested to separate those changes into two patches.

Guenter
