Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:56588 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab2LQC7j (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 16 Dec 2012 21:59:39 -0500
Message-ID: <50CE85D3.3070209@cn.fujitsu.com>
Date: Mon, 17 Dec 2012 10:39:15 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Reply-To: gaowanlong@cn.fujitsu.com
MIME-Version: 1.0
To: Tomas Winkler <tomas.winkler@intel.com>
CC: gregkh@linuxfoundation.org, hdegoede@redhat.com, wim@iguana.be,
	arnd@arndb.de, alan@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Jerry Snitselaar <jerry.snitselaar@oracle.com>
Subject: Re: [char-misc for 3.8] mei: avoid oops in watchdog unregister code
 path
References: <1355656997-30659-1-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1355656997-30659-1-git-send-email-tomas.winkler@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/16/2012 07:23 PM, Tomas Winkler wrote:
> With commit c7d3df3 "mei: use internal watchdog device registration
> tracking" will crash the kernel on shutdown path on systems
> where ME watchdog is not present.
> Since the watchdog was never initialized in such case
> the WDOG_UNREGISTERED bit is never set and the system
> crashes on access to uninitialized variables down the path.
> 
> To solve the issue we query for NULL on watchdog driver driver_data
> to check whether the device is registered. This is handled in the
> driver and doesn't depend on watchdog core internals.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Signed-off-by: Jerry Snitselaar <jerry.snitselaar@oracle.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Fixed the panic here, thank you.

Tested-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  drivers/misc/mei/wd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/misc/mei/wd.c b/drivers/misc/mei/wd.c
> index 636409f..9299a8c 100644
> --- a/drivers/misc/mei/wd.c
> +++ b/drivers/misc/mei/wd.c
> @@ -370,7 +370,7 @@ void mei_watchdog_register(struct mei_device *dev)
>  
>  void mei_watchdog_unregister(struct mei_device *dev)
>  {
> -	if (test_bit(WDOG_UNREGISTERED, &amt_wd_dev.status))
> +	if (watchdog_get_drvdata(&amt_wd_dev) == NULL)
>  		return;
>  
>  	watchdog_set_drvdata(&amt_wd_dev, NULL);
> 

