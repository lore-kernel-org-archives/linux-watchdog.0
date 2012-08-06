Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49042 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756228Ab2HFQOI (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Aug 2012 12:14:08 -0400
Subject: Re: [PATCH 1/1] booke/wdt: fix incorrect WDIOC_GETSUPPORT return path
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <501F35C2.6090005@windriver.com>
Date: Mon, 6 Aug 2012 11:13:55 -0500
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <39951099-55A1-401C-BCA3-5D3E8F731651@kernel.crashing.org>
References: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com> <501F35C2.6090005@windriver.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>,
	Timur Tabi <timur@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Aug 5, 2012, at 10:10 PM, tiejun.chen wrote:

> On 07/30/2012 04:15 PM, Tiejun Chen wrote:
>> We miss that correct WDIOC_GETSUPPORT return path when perform
>> copy_to_user() properly.
> 
> Any comments?
> 
> Thanks
> Tiejun

Adding Timur, as he's touched watchdog last.

- k

>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>> drivers/watchdog/booke_wdt.c |    7 ++++---
>> 1 files changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
>> index 3fe82d0..2be7f29 100644
>> --- a/drivers/watchdog/booke_wdt.c
>> +++ b/drivers/watchdog/booke_wdt.c
>> @@ -162,12 +162,13 @@ static long booke_wdt_ioctl(struct file *file,
>> 				unsigned int cmd, unsigned long arg)
>> {
>> 	u32 tmp = 0;
>> -	u32 __user *p = (u32 __user *)arg;
>> +	void __user *argp = (u32 __user *)arg;
>> +	u32 __user *p = argp;
>> 
>> 	switch (cmd) {
>> 	case WDIOC_GETSUPPORT:
>> -		if (copy_to_user((void *)arg, &ident, sizeof(ident)))
>> -			return -EFAULT;
>> +		return copy_to_user(argp, &ident,
>> +				sizeof(ident)) ? -EFAULT : 0;
>> 	case WDIOC_GETSTATUS:
>> 		return put_user(0, p);
>> 	case WDIOC_GETBOOTSTATUS:
>> 

