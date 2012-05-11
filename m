Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49061 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418Ab2EKQgZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 12:36:25 -0400
Message-ID: <4FAD40EE.90707@redhat.com>
Date: Fri, 11 May 2012 18:40:14 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: Add multiple device support
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk> <20120504123815.GS3074@spo001.leaseweb.com> <20120510192023.GA31117@spo001.leaseweb.com> <4FACC4C1.9040104@redhat.com> <20120511160218.GE3074@spo001.leaseweb.com>
In-Reply-To: <20120511160218.GE3074@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 05/11/2012 06:02 PM, Wim Van Sebroeck wrote:
> Hi Hans,
>
>>> +		if (id != 0)
>>> +			return ret;
>>
>>
>> I believe the check above should be:
>> 		if (id != 0 || ret != -EBUSY)
>> 			return ret;
>>
>> IOW we should not retry the registration if it failed for another reason
>> then the id already being taken by a legacy driver.
>
> Than for readibility we should say:
> 		if (!(id == 0&&  ret == -EBUSY))
> 			return ret

ACK.

Regards,

Hans
