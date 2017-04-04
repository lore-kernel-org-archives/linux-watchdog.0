Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36747 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdDDNt7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 09:49:59 -0400
MIME-Version: 1.0
In-Reply-To: <26b8a87af5084168576cba4feaca689a84abd867.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <bf5a86829e9403d93e85270b2898b3c548417a05.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com> <26b8a87af5084168576cba4feaca689a84abd867.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Apr 2017 16:49:57 +0300
Message-ID: <CAHp75VfyrdVVQ3s4VT_Bfr_ziw4+g16gVMHZtehC7vH1TQQxOQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] watchdog: iTCO_wdt: cleanup set/unset no_reboot calls
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>,
        David Box <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 4, 2017 at 3:24 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Both iTCO_wdt_unset_NO_REBOOT_bit() and iTCO_wdt_unset_NO_REBOOT_bit()
> functions has lot of common code between them. So merging these two
> functions would remove these unnecessary code duplications. This patch
> fixes this issue by creating single update function to handle both
> set/unset functionalities.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Something similar should go before patch 3/6.

-- 
With Best Regards,
Andy Shevchenko
