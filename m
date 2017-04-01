Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:49505 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdDAPHP (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Apr 2017 11:07:15 -0400
Subject: Re: [PATCH 1/3] usb: pci-quirks: Add a header for SB800 I/O ports and
 mutex for locking
To: Greg KH <greg@kroah.com>
References: <20170401100609.9054-1-zboszor@pr.hu>
 <20170401110223.12056-1-zboszor@pr.hu> <20170401110223.12056-2-zboszor@pr.hu>
 <20170401135957.GA9493@kroah.com>
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <d27134ed-3364-1d67-167c-e6bfb8f13559@pr.hu>
Date: Sat, 1 Apr 2017 17:07:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170401135957.GA9493@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

2017-04-01 15:59 keltez=E9ssel, Greg KH =EDrta:
> On Sat, Apr 01, 2017 at 01:02:21PM +0200, Zoltan Boszormenyi wrote:
>> From: B=F6sz=F6rm=E9nyi Zolt=E1n <zboszor@pr.hu>
>>
>> This patch adds:
>> * a mutex in the USB PCI quirks code for synchronizing access to
>>   the I/O ports on SB800
>> * a new header that contains symbols for the index and data I/O ports
>>   and wrappers for locking and unlocking the mutex.
>> * locking around the I/O port access for SB800
>>
>> Signed-off-by: Zoltan Boszormenyi <zboszor@pr.hu>
>> ---
>>  drivers/usb/host/pci-quirks.c | 14 ++++++++++----
>>  include/linux/sb800.h         | 15 +++++++++++++++
>>  2 files changed, 25 insertions(+), 4 deletions(-)
>>  create mode 100644 include/linux/sb800.h
>>
>> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quir=
ks.c
>> index a9a1e4c..9b0445c 100644
>> --- a/drivers/usb/host/pci-quirks.c
>> +++ b/drivers/usb/host/pci-quirks.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/export.h>
>>  #include <linux/acpi.h>
>>  #include <linux/dmi.h>
>> +#include <linux/sb800.h>
>>  #include "pci-quirks.h"
>>  #include "xhci-ext-caps.h"
>>
>> @@ -279,6 +280,9 @@ bool usb_amd_prefetch_quirk(void)
>>  }
>>  EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
>>
>> +DEFINE_MUTEX(sb800_mutex);
>> +EXPORT_SYMBOL_GPL(sb800_mutex);
>> +
>>  /*
>>   * The hardware normally enables the A-link power management feature,=
 which
>>   * lets the system lower the power consumption in idle states.
>> @@ -314,11 +318,13 @@ static void usb_amd_quirk_pll(int disable)
>>  	if (amd_chipset.sb_type.gen =3D=3D AMD_CHIPSET_SB800 ||
>>  			amd_chipset.sb_type.gen =3D=3D AMD_CHIPSET_HUDSON2 ||
>>  			amd_chipset.sb_type.gen =3D=3D AMD_CHIPSET_BOLTON) {
>> -		outb_p(AB_REG_BAR_LOW, 0xcd6);
>> -		addr_low =3D inb_p(0xcd7);
>> -		outb_p(AB_REG_BAR_HIGH, 0xcd6);
>> -		addr_high =3D inb_p(0xcd7);
>> +		enter_sb800();
>> +		outb_p(AB_REG_BAR_LOW, SB800_PIIX4_SMB_IDX);
>> +		addr_low =3D inb_p(SB800_PIIX4_SMB_DATA);
>> +		outb_p(AB_REG_BAR_HIGH, SB800_PIIX4_SMB_IDX);
>> +		addr_high =3D inb_p(SB800_PIIX4_SMB_DATA);
>>  		addr =3D addr_high << 8 | addr_low;
>> +		leave_sb800();
>>
>>  		outl_p(0x30, AB_INDX(addr));
>>  		outl_p(0x40, AB_DATA(addr));
>> diff --git a/include/linux/sb800.h b/include/linux/sb800.h
>> new file mode 100644
>> index 0000000..5650b7d
>> --- /dev/null
>> +++ b/include/linux/sb800.h
>> @@ -0,0 +1,15 @@
>> +
>> +#ifndef SB800_H
>> +#define SB800_H
>> +
>> +#include <linux/mutex.h>
>> +
>> +#define SB800_PIIX4_SMB_IDX		0xcd6
>> +#define SB800_PIIX4_SMB_DATA	0xcd7
>> +
>> +extern struct mutex sb800_mutex;
>> +
>> +#define enter_sb800()	mutex_lock(&sb800_mutex)
>> +#define leave_sb800()	mutex_unlock(&sb800_mutex)
>
> Don't hide the mutex, just spell it out in the code itself.  No need fo=
r
> these defines at all.

Thanks, I will change it.

>
> thanks,
>
> greg k-h
>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
