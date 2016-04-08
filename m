Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40292 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbcDHBGj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Apr 2016 21:06:39 -0400
Subject: Re: [PATCH V3] watchdog: hpwdt: Adjust documentation to match latest
 kernel module parameters
To: "Croxon, Nigel" <nigel.croxon@hpe.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <A4930445748CDC43B8495613130746F44ECEC789@G4W3214.americas.hpqcorp.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57070421.4070603@roeck-us.net>
Date: Thu, 7 Apr 2016 18:06:41 -0700
MIME-Version: 1.0
In-Reply-To: <A4930445748CDC43B8495613130746F44ECEC789@G4W3214.americas.hpqcorp.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/06/2016 06:11 PM, Croxon, Nigel wrote:
> From: Nigel Croxon <nigel.croxon@hpe.com>
> Date: Wed, 6 Apr 2016 14:40:05 -0400
> Subject: [PATCH V3] watchdog: hpwdt: Adjust documentation to match latest kernel module parameters.
>
> Adjust documentation to match latest kernel module parameters.
>
> V3 - Fixed two spelling mistakes.
> V2 - Changed insmod / rmmod to modprobe / modprobe -r
>
> Signed-off-by: Nigel Croxon <nigel.croxon@hpe.com>

Nigel,

when applying this patch:

Applying: watchdog: hpwdt: Adjust documentation to match latest kernel module parameters.
/home/groeck/src/linux-staging/.git/rebase-apply/patch:75: trailing whitespace.
  the hpwdt driver can be reloaded.
/home/groeck/src/linux-staging/.git/rebase-apply/patch:92: trailing whitespace.
  4. modprobe /lib/modules/`uname -r`/kernel/drivers/watchdog/hpwdt.ko
warning: 2 lines add whitespace errors.

Please fix and resubmit.

FWIW, those whitespace errors are also reported with checkpatch.

Thanks,
Guenter

