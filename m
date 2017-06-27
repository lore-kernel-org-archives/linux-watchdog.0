Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50907 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751493AbdF0CQc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Jun 2017 22:16:32 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5R2ERVl026782
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Jun 2017 22:16:31 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bb563v25q-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Jun 2017 22:16:31 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <cbostic@linux.vnet.ibm.com>;
        Mon, 26 Jun 2017 22:16:30 -0400
Subject: Re: [1/2] drivers/watchdog: Document new aspeed optional dev tree
 properties.
To: Guenter Roeck <linux@roeck-us.net>
References: <20170613203818.17399-2-cbostic@linux.vnet.ibm.com>
 <20170624220722.GA3621@roeck-us.net>
Cc: wim@iguana.be, joel@jms.id.au, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, andrew@aj.id.au
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date: Mon, 26 Jun 2017 21:16:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170624220722.GA3621@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <962762c7-6baf-4116-d9d3-32b5ebe6b3c9@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 6/24/17 5:07 PM, Guenter Roeck wrote:
> On Tue, Jun 13, 2017 at 03:38:17PM -0500, Christopher Bostic wrote:
>> Describe new optional property 'external-signal'.  When present in the
>> system device tree an exernal signal is generated on watchdog timeout.
>>
>> Describe new optional property 'no-system-reset'.  When present in the
>> system device tree no system reset is to occur on watchdog timeout.
>> System reset in this case is managed by one of the other watchogs
>> available.
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> This requires DT maintainer approval, but DT maintainers were not copied.
> Please resend and use scripts/get_maintainer.pl to determine who to send
> it to.
>
> Guenter

Hi Guenter,

Will resend with maintainers copied.

Thanks
-Chris

>> ---
>>   Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> index c5e74d7..4099ea5 100644
>> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> @@ -8,9 +8,20 @@ Required properties:
>>    - reg: physical base address of the controller and length of memory mapped
>>      region
>>   
>> +Optional properties:
>> + - external-signal: If the property is present then an external signal is to
>> +   be generated on watchdog timeout.  If absent, external signal is not
>> +   generated.
>> +
>> + - no-system-reset: If the property is present then system will not be reset
>> +   on watchdog timeout. In this case one of the other watchdogs will handle
>> +   reset.  If absent then the watchdog resets the system on timeout.
>> +
>>   Example:
>>   
>>   	wdt1: watchdog@1e785000 {
>>   		compatible = "aspeed,ast2400-wdt";
>>   		reg = <0x1e785000 0x1c>;
>> +		external-signal;
>> +		no-system-reset;
>>   	};

