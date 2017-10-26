Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46060 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932317AbdJZNvJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 26 Oct 2017 09:51:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id d28so2565459pfe.2
        for <linux-watchdog@vger.kernel.org>; Thu, 26 Oct 2017 06:51:09 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] watchdog: i6300esb: support multiple devices
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
References: <20171022170947.GA6997@roeck-us.net>
 <20171025153914.3467-2-rrendec@arista.com>
 <20171025205557.GB30439@roeck-us.net> <1509017701.29929.10.camel@arista.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2edc54c2-f3d9-6b54-7ff9-79365b03946c@roeck-us.net>
Date: Thu, 26 Oct 2017 06:51:07 -0700
MIME-Version: 1.0
In-Reply-To: <1509017701.29929.10.camel@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/26/2017 04:35 AM, Radu Rendec wrote:
> On Wed, 2017-10-25 at 13:55 -0700, Guenter Roeck wrote:
>> On Wed, Oct 25, 2017 at 04:39:12PM +0100, Radu Rendec wrote:
>>> -/* We can only use 1 card due to the /dev/watchdog restriction */
>>> +/* Probed devices counter; used only for printing the initial info message */
>>>   static int cards_found;
>>
>> Now unnecessary.
> 
> [snip]
> 
>>>   static int esb_probe(struct pci_dev *pdev,
>>>   		const struct pci_device_id *ent)
>>>   {
>>> +	struct esb_dev *edev;
>>>   	int ret;
>>>   
>>>   	cards_found++;
>>
>> Now unnecessary.
> 
> This variable is still used for printing the module "greeting" message
> only when the first device is probed. The code snippet is below, but
> unfortunately the diff context doesn't include the condition that tests
> cards_found (the line was originally there, I didn't touch it).
> 
>>> @@ -309,26 +313,33 @@ static int esb_probe(struct pci_dev *pdev,
>>>   		pr_info("Intel 6300ESB WatchDog Timer Driver v%s\n",
>>>   			ESB_VERSION);
>>>   
> 
> So we should either keep the variable or drop the "greeting" message
> altogether. Perhaps it makes more sense if we use it as a bool (rather
> than a counter)? Something like:
> 
> if (!cards_found) {
> 	pr_info(...);
> 	cards_found = 1;
> }
> 

Just drop that pr_info. There is an info message at the end of the probe
function which is sufficient. Make that dev_info if you didn't already,
and it will report additional instance data automatically.

> I fixed the other issues and I will submit a new version of the patch
> series as soon as I get your input on this one.
> 
> Thanks,
> Radu
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

