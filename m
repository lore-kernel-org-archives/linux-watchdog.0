Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51242 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757871Ab2EKImS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 04:42:18 -0400
Message-ID: <4FACD0E2.9000107@redhat.com>
Date: Fri, 11 May 2012 10:42:10 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: Add multiple device support
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk> <20120504123815.GS3074@spo001.leaseweb.com> <20120510192023.GA31117@spo001.leaseweb.com> <4FACC4C1.9040104@redhat.com>
In-Reply-To: <4FACC4C1.9040104@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

<snip>

>> @@ -102,6 +122,7 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
>> ret = watchdog_dev_unregister(wdd);
>> if (ret)
>> pr_err("error unregistering /dev/watchdog (err=%d)\n", ret);
>> + ida_simple_remove(&watchdog_ida, wdd->id);
>> }
>> EXPORT_SYMBOL_GPL(watchdog_unregister_device);
>>
>
> A note to myself :) : This is going to become a problem once we support
> dynamic allocated watchdog structs, as the unregister will unref the struct,
> so it may be gone after the unregister, solution: store id in a local var
> before calling unregister.

Scrap that my support for dynamically allocated watchdog_dev structs patch does
not do an automatic unref on unregister, instead it expects the caller of
unregister to manually do the unref itself (for drivers which use the ref
counting), which actually is better, as it does not cause problems like the
above.

Regards,

Hans
