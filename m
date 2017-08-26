Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63480 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbdHZJdD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 26 Aug 2017 05:33:03 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        "wim@iguana.be" <wim@iguana.be>,
        "linux@roeck-us.net" <linux@roeck-us.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH] watchdog: mei_wdt: constify mei_cl_device_id
Date: Sat, 26 Aug 2017 09:32:59 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B74A091D2@hasmsx109.ger.corp.intel.com>
References: <c46499b73fe258e5fb9f79dcfdb8e825ff910e2a.1503727746.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <c46499b73fe258e5fb9f79dcfdb8e825ff910e2a.1503727746.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


> 
> mei_cl_device_id are not supposed to change at runtime. All functions
> working with mei_cl_device_id provided by <linux/mei_cl_bus.h> work with
> const mei_cl_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Ack.
> ---
>  drivers/watchdog/mei_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c index
> b29c6fd..ea60b29 100644
> --- a/drivers/watchdog/mei_wdt.c
> +++ b/drivers/watchdog/mei_wdt.c
> @@ -670,7 +670,7 @@ static int mei_wdt_remove(struct mei_cl_device
> *cldev)  #define MEI_UUID_WD UUID_LE(0x05B79A6F, 0x4628, 0x4D7F, \
>  			    0x89, 0x9D, 0xA9, 0x15, 0x14, 0xCB, 0x32, 0xAB)
> 
> -static struct mei_cl_device_id mei_wdt_tbl[] = {
> +static const struct mei_cl_device_id mei_wdt_tbl[] = {
>  	{ .uuid = MEI_UUID_WD, .version = MEI_CL_VERSION_ANY },
>  	/* required last entry */
>  	{ }
> --
> 2.7.4

