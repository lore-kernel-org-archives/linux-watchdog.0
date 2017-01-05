Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:42220 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759259AbdAELtt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 5 Jan 2017 06:49:49 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] watchdog: tangox: Use watchdog core to install restart handler
References: <1483565318-25578-1-git-send-email-linux@roeck-us.net>
        <1483565318-25578-4-git-send-email-linux@roeck-us.net>
        <df7b5570-a44d-0c25-fedd-03a0891fdff3@sigmadesigns.com>
Date: Thu, 05 Jan 2017 11:38:49 +0000
In-Reply-To: <df7b5570-a44d-0c25-fedd-03a0891fdff3@sigmadesigns.com> (Marc
        Gonzalez's message of "Thu, 5 Jan 2017 10:42:19 +0100")
Message-ID: <yw1xmvf5ohx2.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> [ Adding Mans ]
>
> Guenter, patch c7ef68c32265 states "Fixes: a3e376d26ace".
> Is that true? I mean, they seem quite orthogonal; then again I know
> nothing of this framework.

I don't see the relation of either of those to this patch.

> On 04/01/2017 22:28, Guenter Roeck wrote:
>> Use the infrastructure provided by the watchdog core to install
>> the restart handler.
>>=20
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  drivers/watchdog/tangox_wdt.c | 32 +++++++++++---------------------
>>  1 file changed, 11 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_w=
dt.c
>> index 202c4b9cc921..49e6e805db7c 100644
>> --- a/drivers/watchdog/tangox_wdt.c
>> +++ b/drivers/watchdog/tangox_wdt.c
>> @@ -15,9 +15,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/moduleparam.h>
>> -#include <linux/notifier.h>
>>  #include <linux/platform_device.h>
>> -#include <linux/reboot.h>
>>  #include <linux/watchdog.h>
>> =20
>>  #define DEFAULT_TIMEOUT 30
>> @@ -47,7 +45,6 @@ struct tangox_wdt_device {
>>  	void __iomem *base;
>>  	unsigned long clk_rate;
>>  	struct clk *clk;
>> -	struct notifier_block restart;
>>  };
>> =20
>>  static int tangox_wdt_set_timeout(struct watchdog_device *wdt,
>> @@ -96,24 +93,24 @@ static const struct watchdog_info tangox_wdt_info =
=3D {
>>  	.identity =3D "tangox watchdog",
>>  };
>> =20
>> +static int tangox_wdt_restart(struct watchdog_device *wdt,
>> +			      unsigned long action, void *data)
>> +{
>> +	struct tangox_wdt_device *dev =3D watchdog_get_drvdata(wdt);
>> +
>> +	writel(1, dev->base + WD_COUNTER);
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct watchdog_ops tangox_wdt_ops =3D {
>>  	.start		=3D tangox_wdt_start,
>>  	.stop		=3D tangox_wdt_stop,
>>  	.set_timeout	=3D tangox_wdt_set_timeout,
>>  	.get_timeleft	=3D tangox_wdt_get_timeleft,
>> +	.restart	=3D tangox_wdt_restart,
>>  };
>> =20
>> -static int tangox_wdt_restart(struct notifier_block *nb, unsigned lon=
g action,
>> -			      void *data)
>> -{
>> -	struct tangox_wdt_device *dev =3D
>> -		container_of(nb, struct tangox_wdt_device, restart);
>> -
>> -	writel(1, dev->base + WD_COUNTER);
>> -
>> -	return NOTIFY_DONE;
>> -}
>> -
>>  static int tangox_wdt_probe(struct platform_device *pdev)
>>  {
>>  	struct tangox_wdt_device *dev;
>> @@ -180,12 +177,6 @@ static int tangox_wdt_probe(struct platform_devic=
e *pdev)
>> =20
>>  	platform_set_drvdata(pdev, dev);
>> =20
>> -	dev->restart.notifier_call =3D tangox_wdt_restart;
>> -	dev->restart.priority =3D 128;
>> -	err =3D register_restart_handler(&dev->restart);
>> -	if (err)
>> -		dev_warn(&pdev->dev, "failed to register restart handler\n");
>> -
>>  	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
>> =20
>>  	return 0;
>> @@ -202,7 +193,6 @@ static int tangox_wdt_remove(struct platform_devic=
e *pdev)
>>  	tangox_wdt_stop(&dev->wdt);
>>  	clk_disable_unprepare(dev->clk);
>> =20
>> -	unregister_restart_handler(&dev->restart);
>>  	watchdog_unregister_device(&dev->wdt);
>> =20
>>  	return 0;
>>=20

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
