Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 10 Mar 2014 18:06:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Tyser <ptyser@xes-inc.com>
Cc: linux-kernel@vger.kernel.org, James Ralston <james.d.ralston@intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/8] watchdog: iTCO_wdt: Add support for v3 silicon
Message-ID: <20140311010652.GE32676@roeck-us.net>
References: <1394487298-14459-1-git-send-email-ptyser@xes-inc.com>
 <1394487298-14459-5-git-send-email-ptyser@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1394487298-14459-5-git-send-email-ptyser@xes-inc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Mar 10, 2014 at 04:34:55PM -0500, Peter Tyser wrote:
> Some new Atom's, eg Avoton and Bay Trail, have slightly different iTCO
> functionality:
> - The watchdog timer ticks at 1 second instead of .6 seconds
> 
> - Some 8 and 16-bit registers were combined into 32-bit registers
> 
> - Some registers were removed (DAT_IN, DAT_OUT, MESSAGE)
> 
> - The BOOT_STS field in TCO_STS was removed
> 
> - The NO_REBOOT bit is in the PMC area instead of GCS
> 
> Update the driver to support the above changes and bump the version to
> 1.11.
> 
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
> Tested-by: Rajat Jain <rajatjain@juniper.net>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: James Ralston <james.d.ralston@intel.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
