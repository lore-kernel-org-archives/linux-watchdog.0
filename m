Return-path: <tomas.winkler@intel.com>
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [watchdog-next] watchdog: kill unref/ref ops
Date: Mon, 4 Jan 2016 23:38:20 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B541154C0@hasmsx108.ger.corp.intel.com>
References: <1451820757-8840-1-git-send-email-tomas.winkler@intel.com>
 <568942BF.2090402@roeck-us.net>
In-Reply-To: <568942BF.2090402@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>



> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Sunday, January 03, 2016 17:48
> To: Winkler, Tomas; Wim Van Sebroeck
> Cc: linux-watchdog@vger.kernel.org
> Subject: Re: [watchdog-next] watchdog: kill unref/ref ops
>=20
> On 01/03/2016 03:32 AM, Tomas Winkler wrote:
> > ref/unref ops are not called at all so even marked them as deprecated
> > is misleading, we need to just drop the API.
> >
> One the other side, the functions are now no-ops, so they don't hurt eith=
er.
> Only reason for not dropping the functions as part of my series was that
> the mei watchdog code was starting to implement them, and I didn't want
> to create dependencies for that code. Maybe my thinking was too conservat=
ive.
>=20
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>=20
> ... of course that is no concern anymore since this patch is from its
> maintainer.
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Now I'm looking into the current code and one thing I do not understand , i=
f the watchdog_core_data is holding
a pointer to wdd, who is responsible for wdd and who is holding the referen=
ce counter on that pointer.
If the underlying driver will release the wdd (for any reason) your code wi=
ll read junk.=20
I think wdd should not be a pointer here.

/*
 * struct watchdog_core_data - watchdog core internal data
 * @kref:       Reference count.
 * @cdev:       The watchdog's Character device.
 * @wdd:        Pointer to watchdog device.
 * @lock:       Lock for watchdog core.
 * @status:     Watchdog core internal status bits.
 */
struct watchdog_core_data {
        struct kref kref;
        struct cdev cdev;
        struct watchdog_device *wdd;
        struct mutex lock;
        unsigned long status;           /* Internal status bits */
#define _WDOG_DEV_OPEN          0       /* Opened ? */
#define _WDOG_ALLOW_RELEASE     1       /* Did we receive the magic char ? =
*/
};

Thanks
Tomas=20
