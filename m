Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "sparmaintainer@unisys.com" <sparmaintainer@unisys.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
CC: KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH v1 4/6] vmbus: Switch to use new generic UUID API
Date: Wed, 19 Jul 2017 20:18:24 +0000
Message-ID: <MWHPR21MB04791ED8A0F0F935176AE9B3CAA60@MWHPR21MB0479.namprd21.prod.outlook.com>
References: <20170719182857.73693-1-andriy.shevchenko@linux.intel.com>
 <20170719182857.73693-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170719182857.73693-5-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>



> -----Original Message-----
> From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> Sent: Wednesday, July 19, 2017 2:29 PM
> To: linux-acpi@vger.kernel.org; devel@linuxdriverproject.org;
> sparmaintainer@unisys.com; devel@driverdev.osuosl.org; linux-
> wireless@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-
> efi@vger.kernel.org; Christoph Hellwig <hch@lst.de>; linux-
> kernel@vger.kernel.org; Lukas Wunner <lukas@wunner.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>
> Subject: [PATCH v1 4/6] vmbus: Switch to use new generic UUID API
> 


> @@ -118,8 +116,8 @@ enum hv_fcopy_op {
> 
>  struct hv_fcopy_hdr {
>  	__u32 operation;
> -	uuid_le service_id0; /* currently unused */
> -	uuid_le service_id1; /* currently unused */
> +	__u8 service_id0[16]; /* currently unused */
> +	__u8 service_id1[16]; /* currently unused */
>  } __attribute__((packed));

Even user space may not have all guid_t operations, could you still
put guid_t here for consistency? This file is also used by our kernel
mode code.

Thanks,
- Haiyang
