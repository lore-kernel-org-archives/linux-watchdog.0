Return-path: <Ezequiel.Garcia@imgtec.com>
Message-ID: <555DE461.2070002@imgtec.com>
Date: Thu, 21 May 2015 10:57:53 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>, Andrew Bresticker
	<abrestic@chromium.org>, James Hogan <james.hogan@imgtec.com>, James Hartley
	<james.hartley@imgtec.com>, Naidu Tellapati <naidu.tellapati@imgtec.com>
Subject: Re: [PATCH 0/2] watchdog: imgpdc_wdt assorted fixes
References: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Wim,

Do you plan to take this for v4.2?

Thanks!

On 05/11/2015 02:41 PM, Ezequiel Garcia wrote:
> Hi,
> 
> A couple more fixes for IMG watchdog driver.
> 
> This first patch corrects the max_timeout setting which was wrongly
> set in cycles.
> 
> The second patch documents the driver's timeout round-up, which
> might seem a bit unintuitive. See the patch for more details.
> 
> Both patches are based on the three imgpdc patches sent recently by
> Andrew Bresticker [1].
> 
> [1] http://www.spinics.net/lists/linux-watchdog/msg06107.html
> 
> Thanks!
> 
> Ezequiel Garcia (2):
>   watchdog: imgpdc: Fix max timeout
>   watchdog: imgpdc: Add some documentation about the timeout
> 

-- 
Ezequiel
