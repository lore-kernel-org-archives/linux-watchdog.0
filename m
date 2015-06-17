Return-path: <andy.shevchenko@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1434548072-3334-1-git-send-email-francois-nicolas.muller@intel.com>
References: <55810251.6070106@roeck-us.net>
	<1434548072-3334-1-git-send-email-francois-nicolas.muller@intel.com>
Date: Wed, 17 Jun 2015 19:06:05 +0300
Message-ID: <CAHp75Vc6hBqNS+peER+14yWidhvdbGDSBv9YQkV4WETjhah4nQ@mail.gmail.com>
Subject: Re: [PATCH v3] TCO watchdog pretimeout handler
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
Cc: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jun 17, 2015 at 4:34 PM, Francois-Nicolas Muller
<francois-nicolas.muller@intel.com> wrote:

First of all it would be nice to start a new thread per iteration.

> Use TCO watchdog first timeout (pretimeout) to dump CPU backtraces
> and ease debug of watchdog expiration causes.
> On Intel Cherrytrail, TCO logic generates a SMI, then SMI handler
> triggers a SCI to the kernel, on a specific GPE.
> The GPE handler dumps all CPU backtraces and calls panic (in order
> to execute registered panic callbacks).
> GPE number is configured from ACPI tables if LPC HID exists.
>
> Signed-off-by: Francois-Nicolas Muller <francois-nicolas.muller@intel.com=
>
> ---
> SMI is not supported by the driver, only SCI.
>
> On Intel Cherrytrail, TCO watchdog raises an SMI, then the SMI handler
> in Bios trigs a SCI to the kernel (in Android OS configuration).
>
> The patch has some effect only on Cherrytrail platform.
> On Braswell, the TCO HID exists in ACPI tables, so SCI is configured. But
> the SMI handler does not trig the SCI.
> On other platforms, the HID does not exist in ACPI tables, and the SMI
> handler does not trig the SCI.
>
> In ACPI tables, _GPE is associated to this HID, so no possible confusion.
>
> Fran=C3=A7ois-Nicolas
> ---
>  drivers/watchdog/iTCO_wdt.c | 50 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 3c3fd41..3e9ec8b 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -68,6 +68,8 @@
>  #include <linux/io.h>                  /* For inb/outb/... */
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/lpc_ich.h>
> +#include <linux/nmi.h>
> +#include <linux/acpi.h>
>
>  #include "iTCO_vendor.h"
>
> @@ -127,6 +129,12 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
>  MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
>         "Turn off SMI clearing watchdog (depends on TCO-version)(default=
=3D1)");
>
> +#define DEFAULT_PRETIMEOUT 0
> +static bool pretimeout =3D DEFAULT_PRETIMEOUT;

Static variables should not be assigned to zero explicitly (it doesn't
make sense).
Moreover you have integer -> boolean implicit conversion.

> +module_param(pretimeout, bool, 0);
> +MODULE_PARM_DESC(pretimeout, "Enable watchdog pretimeout (default=3D"
> +                               __MODULE_STRING(DEFAULT_PRETIMEOUT) ")");

Since it's boolean, I suppose to use direct value here. It would be one lin=
e.

> +
>  /*
>   * Some TCO specific functions
>   */
> @@ -201,6 +209,45 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
>         return ret; /* returns: 0 =3D OK, -EIO =3D Error */
>  }
>

The below should go under CONFIG_ACPI.

> +static unsigned char *tco_hid =3D "8086229C"; /* Intel Cherrytrail LPC *=
/

Why not to use acpi_device_id ?

> +
> +static u32 iTCO_wdt_pretimeout_handler(acpi_handle gpe_device, u32 gpe,
> +                                      void *context)
> +{
> +       /* dump backtraces for all available cores */
> +       trigger_all_cpu_backtrace();
> +
> +       /* call panic notifiers */
> +       panic("Kernel Watchdog");
> +
> +       return ACPI_INTERRUPT_HANDLED;
> +}
> +
> +static acpi_status __init iTCO_wdt_register_gpe(acpi_handle handle,
> +                                       u32 lvl, void *context, void **rv=
)
> +{
> +       unsigned long long gpe;
> +       acpi_status status;
> +       union acpi_object object =3D { 0 };
> +       struct acpi_buffer buffer =3D { sizeof(union acpi_object), &objec=
t };
> +
> +       status =3D acpi_evaluate_object(handle, "_GPE", NULL, &buffer);
> +       if (ACPI_FAILURE(status))
> +               return status;
> +
> +       if (object.type !=3D ACPI_TYPE_INTEGER)
> +               return AE_BAD_DATA;

Do we really need this right now? Existing users of _GPE are
considering the result as integer w/o an additional check.

> +
> +       gpe =3D object.integer.value;
> +       status =3D acpi_install_gpe_handler(NULL, gpe, ACPI_GPE_EDGE_TRIG=
GERED,
> +                                         iTCO_wdt_pretimeout_handler, NU=
LL);

> +       if (ACPI_FAILURE(status))
> +               return status;
> +
> +       acpi_enable_gpe(NULL, gpe);
> +       return AE_OK;
> +}
> +
>  static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>  {
>         unsigned int val;
> @@ -641,6 +688,9 @@ static int __init iTCO_wdt_init_module(void)
>         if (err)
>                 return err;
>
> +       if (pretimeout)
> +               acpi_get_devices(tco_hid, iTCO_wdt_register_gpe, NULL, NU=
LL);
> +
>         return 0;
>  }
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--=20
With Best Regards,
Andy Shevchenko
