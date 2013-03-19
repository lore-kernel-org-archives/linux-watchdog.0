Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932964Ab3CSR0h (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Mar 2013 13:26:37 -0400
Message-ID: <51489FC2.40806@draigBrady.com>
Date: Tue, 19 Mar 2013 17:26:26 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] watchdog: w83627hf: Enable watchdog only once
References: <1362957300-18223-1-git-send-email-linux@roeck-us.net> <1362957300-18223-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1362957300-18223-3-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 03/10/2013 11:14 PM, Guenter Roeck wrote:
> It is unnecessary to enable the logical device and WDT0 each time
> the watchdog is accessed. Do it only once during initialization.

Is this also the case on systems where the superio
chip is used for other things? I've the impression
that this may break some systems (though I no longer
have the hardware to test). Arbitration of multiple
users of the superio device may be managed be a central
user space app, or by a kernel level arbitrator.

thanks,
P=E1draig.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
