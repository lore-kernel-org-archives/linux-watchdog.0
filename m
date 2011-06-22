Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mtaext1.cujae.edu.cu ([200.55.139.24]:46413 "EHLO
	mtaext1.cujae.edu.cu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758573Ab1FVVX5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 17:23:57 -0400
Received: from newton.cujae.edu.cu (newton [10.8.1.213])
	by mtaext1.cujae.edu.cu (Postfix) with ESMTP id ADFB43E005
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jun 2011 17:20:56 -0400 (EDT)
Received: from udio.cujae.edu.cu (udio.cujae.edu.cu [10.8.57.5])
	by newton.cujae.edu.cu (Postfix) with ESMTP id 19F5824063
	for <linux-watchdog@vger.kernel.org>;
	Wed, 22 Jun 2011 15:48:20 -0400 (EDT)
Received: from [10.9.3.110] by udio.cujae.edu.cu (MDaemon PRO v10.1.2)
	with ESMTP id md50000186282.msg
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jun 2011 17:15:40 -0400
Message-ID: <4E025DC8.9090202@udio.cujae.edu.cu>
Date: Wed, 22 Jun 2011 17:25:28 -0400
From: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 7/10 v2] Generic Watchdog Timer Driver
References: <20110618172537.GH3441@infomag.iguana.be>
In-Reply-To: <20110618172537.GH3441@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi
> --- linux-2.6.38-generic-part6/drivers/watchdog/core/watchdog_dev.c	2011-06-16 22:52:56.763937624 +0200
> +++ linux-2.6.38-generic-part7/drivers/watchdog/core/watchdog_dev.c	2011-06-17 09:52:32.870632731 +0200
> @@ -126,11 +126,15 @@
>    *	Stop the watchdog if it is still active and unmark it active.
>    *	This function returns zero on success or a negative errno code for
>    *	failure.
> + *	If the 'nowayout' feature was set, the watchdog cannot be stopped.
>    */
>
>   static int watchdog_stop(struct watchdog_device *wddev)
>   {
> -	int err;
> +	int err = -1;
> +
> +	if (test_bit(WDOG_NO_WAY_OUT,&wdd->status))
> +		return err;
>

If you return err at this point you never clean the bit WDOG_ACTIVE then 
the timer will keep resetting the wdt because the bit is still active.

>   	if (test_bit(WDOG_ACTIVE,&wdd->status)) {
>   		err = wddev->ops->stop(wddev);
> @@ -151,7 +155,7 @@
>    *
>    *	A write to a watchdog device is defined as a keepalive ping.
>    *	Writing the magic 'V' sequence allows the next close to turn
> - *	off the watchdog.
> + *	off the watchdog (if 'nowayout' is not set).
>    */
>
>   static ssize_t watchdog_write(struct file *file, const char __user *data,
> diff -urN linux-2.6.38-generic-part6/include/linux/watchdog.h linux-2.6.38-generic-part7/include/linux/watchdog.h
> --- linux-2.6.38-generic-part6/include/linux/watchdog.h	2011-06-17 12:17:15.285063678 +0200
> +++ linux-2.6.38-generic-part7/include/linux/watchdog.h	2011-06-17 12:17:39.205063756 +0200
> @@ -86,6 +86,7 @@
>   #define WDOG_DEV_OPEN		1	/* is the watchdog opened via
>   					 * /dev/watchdog */
>   #define WDOG_EXPECT_RELEASE	2	/* did we receive the magic char ? */
> +#define WDOG_NO_WAY_OUT		3	/* is 'nowayout' feature set ? */
>   };
>
>   /* drivers/watchdog/core/watchdog_core.c */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Participe en Universidad 2012, del 13 al 17 de febrero de 2012.
Habana, Cuba: http://www.congresouniversidad.cu
Consulte la enciclopedia colaborativa cubana. http://www.ecured.cu

Participe en el Segundo Congreso Medio Ambiente Construido y 
Desarrollo Sustentable (MACDES 2011) del 6 al 9 de diciembre de 2011, 
Hotel Nacional, Habana, Cuba: http://macdes.cujae.edu.cu
