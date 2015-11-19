Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:50871 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934176AbbKSQab convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Nov 2015 11:30:31 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: add support for Sigma Designs SMP86xx/SMP87xx
References: <1447869343-25168-1-git-send-email-mans@mansr.com>
	<1447869343-25168-2-git-send-email-mans@mansr.com>
	<564DF807.3040608@roeck-us.net>
Date: Thu, 19 Nov 2015 16:30:22 +0000
In-Reply-To: <564DF807.3040608@roeck-us.net> (Guenter Roeck's message of "Thu,
	19 Nov 2015 08:25:43 -0800")
Message-ID: <yw1xziyadk9t.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

>> +	writel(WD_CONFIG_XTAL_IN, dev->base + WD_CONFIG);
>
> What happens if the DISABLE bit was previously set (assuming
> that DISABLE means that the watchdog is disabled) ?
>
> Concern I guess would be the combination of DISABLE being set
> and WD_COUNTER at a value !=3D 0 (say, 1). That might effectively
> auto-enable the watchdog or even reset the system.

There's no sane reason why it would be in that state, but then again
firmware authors are not sane.

How about checking the DISABLE bit, and if it's set turn off the
counter, otherwise leave it running?

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
