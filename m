Return-path: <denis.turischev@compulab.co.il>
Subject: Re: [PATCH] sp5100_tco: Add AMD Mullins platform support
To: Huang Rui <ray.huang@amd.com>, Guenter Roeck <linux@roeck-us.net>
References: <564D9CB0.1090209@compulab.co.il>
 <20151120023322.GB21619@hr-amur2>
Cc: Wim Van Sebroeck <wim@iguana.be>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Vincent Wan <vincent.wan@amd.com>
From: Denis Turischev <denis.turischev@compulab.co.il>
Message-ID: <565182B0.9070604@compulab.co.il>
Date: Sun, 22 Nov 2015 10:54:08 +0200
MIME-Version: 1.0
In-Reply-To: <20151120023322.GB21619@hr-amur2>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Rui,

On 11/20/2015 04:33 AM, Huang Rui wrote:
> Hi Denis,
> 
> On Thu, Nov 19, 2015 at 05:56:00PM +0800, Denis Turischev wrote:
>> AMD Mullins watchdog is fully compatible to the previous Hudson chipset,
>> reuse the existent sp5100_tco driver.
>>
> 
> Thank you to add this support!
> Actually, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS is only the SMBus device id
> on AMD mullins but also on many other AMD platforms. Could you please
> share some test method to me, that I am glad to do some quick tests. :)

My device is Compulabs's fitlet. It's a fanless mini PC, also known as mintbox mini.
http://fit-pc.com/wiki/index.php/Fit-PC_Product_Line:_fitlet
Processor's datasheet:
http://support.amd.com/TechDocs/52740_16h_Models_30h-3Fh_BKDG.pdf

The dmesg output:
sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
sp5100_tco: PCI Revision ID: 0x42
sp5100_tco: Using 0xfeb00000 for watchdog MMIO address
sp5100_tco: Last reboot was not triggered by watchdog.
sp5100_tco: initialized (0xffffc90000702000). heartbeat=60 sec (nowayout=0)

Please let me know if you need any other info or tests to be performed.

Denis

> 
> Thanks,
> Rui
> 
>> Signed-off-by: Denis Turischev <denis.turischev@compulab.co.il>
>>
>> diff -Nru linux-4.3.orig/drivers/watchdog/sp5100_tco.c linux-4.3/drivers/watchdog/sp5100_tco.c
>> --- linux-4.3.orig/drivers/watchdog/sp5100_tco.c	2015-11-02 02:05:25.000000000 +0200
>> +++ linux-4.3/drivers/watchdog/sp5100_tco.c	2015-11-19 11:08:06.272777718 +0200
>> @@ -306,6 +306,8 @@
>>  static const struct pci_device_id sp5100_tco_pci_tbl[] = {
>>  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
>>  	  PCI_ANY_ID, },
>> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
>> +	  PCI_ANY_ID, },
>>  	{ 0, },			/* End of list */
>>  };
>>  MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);	
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
