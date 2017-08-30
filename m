Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42635 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdH3Dag (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 23:30:36 -0400
Date: Tue, 29 Aug 2017 20:28:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomas.winkler@intel.com, wim@iguana.be,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: watchdog: mei_wdt: constify mei_cl_device_id
Message-ID: <20170830032829.GA14278@roeck-us.net>
References: <c46499b73fe258e5fb9f79dcfdb8e825ff910e2a.1503727746.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46499b73fe258e5fb9f79dcfdb8e825ff910e2a.1503727746.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 26, 2017 at 11:41:06AM +0530, Arvind Yadav wrote:
> mei_cl_device_id are not supposed to change at runtime. All functions
> working with mei_cl_device_id provided by <linux/mei_cl_bus.h> work
> with const mei_cl_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mei_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> index b29c6fd..ea60b29 100644
> --- a/drivers/watchdog/mei_wdt.c
> +++ b/drivers/watchdog/mei_wdt.c
> @@ -670,7 +670,7 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
>  #define MEI_UUID_WD UUID_LE(0x05B79A6F, 0x4628, 0x4D7F, \
>  			    0x89, 0x9D, 0xA9, 0x15, 0x14, 0xCB, 0x32, 0xAB)
>  
> -static struct mei_cl_device_id mei_wdt_tbl[] = {
> +static const struct mei_cl_device_id mei_wdt_tbl[] = {
>  	{ .uuid = MEI_UUID_WD, .version = MEI_CL_VERSION_ANY },
>  	/* required last entry */
>  	{ }
