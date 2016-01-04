Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39407 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbcADX6H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Jan 2016 18:58:07 -0500
Subject: Re: [watchdog-next] watchdog: kill unref/ref ops
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1451820757-8840-1-git-send-email-tomas.winkler@intel.com>
 <568942BF.2090402@roeck-us.net>
 <5B8DA87D05A7694D9FA63FD143655C1B541154C0@hasmsx108.ger.corp.intel.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <568B070D.8000306@roeck-us.net>
Date: Mon, 4 Jan 2016 15:58:05 -0800
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B541154C0@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/04/2016 03:38 PM, Winkler, Tomas wrote:
>
>
>> -----Original Message-----
>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>> Sent: Sunday, January 03, 2016 17:48
>> To: Winkler, Tomas; Wim Van Sebroeck
>> Cc: linux-watchdog@vger.kernel.org
>> Subject: Re: [watchdog-next] watchdog: kill unref/ref ops
>>
>> On 01/03/2016 03:32 AM, Tomas Winkler wrote:
>>> ref/unref ops are not called at all so even marked them as deprecated
>>> is misleading, we need to just drop the API.
>>>
>> One the other side, the functions are now no-ops, so they don't hurt either.
>> Only reason for not dropping the functions as part of my series was that
>> the mei watchdog code was starting to implement them, and I didn't want
>> to create dependencies for that code. Maybe my thinking was too conservative.
>>
>>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>>
>> ... of course that is no concern anymore since this patch is from its
>> maintainer.
>>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> Now I'm looking into the current code and one thing I do not understand , if the watchdog_core_data is holding
> a pointer to wdd, who is responsible for wdd and who is holding the reference counter on that pointer.
> If the underlying driver will release the wdd (for any reason) your code will read junk.
> I think wdd should not be a pointer here.
>
The pointer is cleared when the watchdog device is removed (in watchdog_cdev_unregister,
which is called from watchdog_dev_unregister), and the cleared pointer is used by
the watchdog core as indication that the driver is no longer accessible.
This replaces the WDOG_UNREGISTERED flag.

Guenter

> /*
>   * struct watchdog_core_data - watchdog core internal data
>   * @kref:       Reference count.
>   * @cdev:       The watchdog's Character device.
>   * @wdd:        Pointer to watchdog device.
>   * @lock:       Lock for watchdog core.
>   * @status:     Watchdog core internal status bits.
>   */
> struct watchdog_core_data {
>          struct kref kref;
>          struct cdev cdev;
>          struct watchdog_device *wdd;
>          struct mutex lock;
>          unsigned long status;           /* Internal status bits */
> #define _WDOG_DEV_OPEN          0       /* Opened ? */
> #define _WDOG_ALLOW_RELEASE     1       /* Did we receive the magic char ? */
> };
>
> Thanks
> Tomas
>

