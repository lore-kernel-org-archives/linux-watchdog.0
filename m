Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64899 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752785AbdKWN4N (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 23 Nov 2017 08:56:13 -0500
Date: Thu, 23 Nov 2017 15:56:06 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, alexandre.belloni@free-electrons.com,
        qipeng.zha@intel.com, hpa@zytor.com, dvhart@infradead.org,
        tglx@linutronix.de, lee.jones@linaro.org, andy@infradead.org,
        souvik.k.chakravarty@intel.com, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com
Subject: Re: [RFC v8 0/7] SCU/PMC/PUNIT Inter-Processor Communication(IPC)
 driver cleanup
Message-ID: <20171123135606.GF17418@kuha.fi.intel.com>
References: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Sun, Oct 29, 2017 at 02:49:53AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> Currently intel_pmc_ipc.c, intel_punit_ipc.c, intel_scu_ipc.c drivers
> implements the same IPC features. This code duplication could be avoided if we
> implement the IPC driver as a generic library and let custom device drivers
> use API provided by generic driver. This patchset mainly addresses this issue.
> 
> Along with above code duplication issue, This patchset also addresses
> following issues in intel_pmc_ipc and intel_punit_ipc drivers.
> 
> 1. Intel_pmc_ipc.c driver does not use any resource managed (devm_*) calls.
> 2. In Intel_pmc_ipc.c driver, dependent devices like PUNIT, Telemetry and iTCO
> are created manually and uses lot of redundant buffer code.
> 3. Global variable is used to store the IPC device structure and it is used
> across all functions in intel_pmc_ipc.c and intel_punit_ipc.c.

I think those changes are definitely welcome. On top of those, I want
to have regmap for using the IPC. It does not make any sense that the
drivers for the devices attached to for example the PMC, like the
WhiskeyCove PMIC, have to implement their own regmaps.

But a class for the IPC library does feel like overkill to me.


Thanks,

-- 
heikki
