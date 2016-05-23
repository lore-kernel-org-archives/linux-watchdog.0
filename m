Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38548 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbcEWO4P (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 10:56:15 -0400
Subject: Re: [PATCH] watchdog: hpwdt: update HPE maintainer
To: Brian Boylston <brian.boylston@hpe.com>,
	linux-watchdog@vger.kernel.org
References: <20160523133329.10075-1-brian.boylston@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57431A13.1040406@roeck-us.net>
Date: Mon, 23 May 2016 07:56:19 -0700
MIME-Version: 1.0
In-Reply-To: <20160523133329.10075-1-brian.boylston@hpe.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Brian,

On 05/23/2016 06:33 AM, Brian Boylston wrote:
> Update the HPE maintainer of the hpwdt driver.
>
> Signed-off-by: Brian Boylston <brian.boylston@hpe.com>

A driver's maintainer is commonly updated in MAINTAINERS, not in the driver itself.
If you are the formal maintainer, I would suggest to add an entry for the driver
into the MAINTAINERS file; this would ensure that you get copied on patches
affecting the driver.

Thanks,
Guenter

> ---
> This patch applies on top of:
> [PATCH V4] watchdog: hpwdt: Adjust documentation to match latest kernel module parameters.
> which I think is already in linux-watchdog-next.
>
>   Documentation/watchdog/hpwdt.txt | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
> index a40398c..27106ff 100644
> --- a/Documentation/watchdog/hpwdt.txt
> +++ b/Documentation/watchdog/hpwdt.txt
> @@ -1,9 +1,12 @@
> -Last reviewed: 04/04/2016
> +Last reviewed: 05/20/2016
>
>                        HPE iLO NMI Watchdog Driver
>                 NMI sourcing for iLO based ProLiant Servers
>                        Documentation and Driver by
> -              Thomas Mingarelli <thomas.mingarelli@hpe.com>
> +                         Thomas Mingarelli
> +
> +                       Currently maintained by
> +               Brian Boylston <brian.boylston@hpe.com>
>
>    The HPE iLO NMI Watchdog driver is a kernel module that provides basic
>    watchdog functionality and the added benefit of NMI sourcing. Both the
> @@ -95,4 +98,3 @@ Last reviewed: 04/04/2016
>
>
>    -- Tom Mingarelli
> -    (thomas.mingarelli@hpe.com)
>

