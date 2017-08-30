Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43532 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdH3EeM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 30 Aug 2017 00:34:12 -0400
Date: Tue, 29 Aug 2017 21:34:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Steven J. Hill" <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 7/8] watchdog: octeon-wdt: Add support for cn68XX SOCs.
Message-ID: <20170830043404.GC14791@roeck-us.net>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
 <1504021238-3184-8-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504021238-3184-8-git-send-email-steven.hill@cavium.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 29, 2017 at 10:40:37AM -0500, Steven J. Hill wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/octeon-wdt-main.c | 48 +++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
> index 73b5102..410800f 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -69,6 +69,9 @@
>  
>  #include <asm/octeon/octeon.h>
>  #include <asm/octeon/cvmx-boot-vector.h>
> +#include <asm/octeon/cvmx-ciu2-defs.h>
> +
> +static int divisor;
>  
>  /* The count needed to achieve timeout_sec. */
>  static unsigned int timeout_cnt;
> @@ -227,10 +230,10 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
>  	u64 cp0_epc = read_c0_epc();
>  
>  	/* Delay so output from all cores output is not jumbled together. */
> -	__delay(100000000ull * coreid);
> +	udelay(85000 * coreid);
>  
>  	octeon_wdt_write_string("\r\n*** NMI Watchdog interrupt on Core 0x");
> -	octeon_wdt_write_hex(coreid, 1);
> +	octeon_wdt_write_hex(coreid, 2);
>  	octeon_wdt_write_string(" ***\r\n");
>  	for (i = 0; i < 32; i++) {
>  		octeon_wdt_write_string("\t");
> @@ -253,11 +256,28 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
>  	octeon_wdt_write_hex(cp0_cause, 16);
>  	octeon_wdt_write_string("\r\n");
>  
> -	octeon_wdt_write_string("\tsum0\t0x");
> -	octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_SUM0(coreid * 2)), 16);
> -	octeon_wdt_write_string("\ten0\t0x");
> -	octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2)), 16);
> -	octeon_wdt_write_string("\r\n");
> +	/* The CIU register is different for each Octeon model. */
> +	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
> +		octeon_wdt_write_string("\tsrc_wd\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_SRC_PPX_IP2_WDOG(coreid)), 16);
> +		octeon_wdt_write_string("\ten_wd\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_EN_PPX_IP2_WDOG(coreid)), 16);
> +		octeon_wdt_write_string("\r\n");
> +		octeon_wdt_write_string("\tsrc_rml\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_SRC_PPX_IP2_RML(coreid)), 16);
> +		octeon_wdt_write_string("\ten_rml\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_EN_PPX_IP2_RML(coreid)), 16);
> +		octeon_wdt_write_string("\r\n");
> +		octeon_wdt_write_string("\tsum\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_SUM_PPX_IP2(coreid)), 16);
> +		octeon_wdt_write_string("\r\n");
> +	} else if (!octeon_has_feature(OCTEON_FEATURE_CIU3)) {
> +		octeon_wdt_write_string("\tsum0\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_SUM0(coreid * 2)), 16);
> +		octeon_wdt_write_string("\ten0\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2)), 16);
> +		octeon_wdt_write_string("\r\n");
> +	}
>  
>  	octeon_wdt_write_string("*** Chip soft reset soon ***\r\n");
>  }
> @@ -366,7 +386,7 @@ static void octeon_wdt_calc_parameters(int t)
>  
>  	countdown_reset = periods > 2 ? periods - 2 : 0;
>  	heartbeat = t;
> -	timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * timeout_sec) >> 8;
> +	timeout_cnt = ((octeon_get_io_clock_rate() / divisor) * timeout_sec) >> 8;
>  }
>  
>  static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
> @@ -437,9 +457,7 @@ static enum cpuhp_state octeon_wdt_online;
>   */
>  static int __init octeon_wdt_init(void)
>  {
> -	int i;
>  	int ret;
> -	u64 *ptr;
>  
>  	octeon_wdt_bootvector = cvmx_boot_vector_get();
>  	if (!octeon_wdt_bootvector) {
> @@ -447,10 +465,15 @@ static int __init octeon_wdt_init(void)
>  		return -ENOMEM;
>  	}
>  
> +	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
> +		divisor = 0x200;
> +	else
> +		divisor = 0x100;
> +
>  	/*
>  	 * Watchdog time expiration length = The 16 bits of LEN
>  	 * represent the most significant bits of a 24 bit decrementer
> -	 * that decrements every 256 cycles.
> +	 * that decrements every divisor cycle.
>  	 *
>  	 * Try for a timeout of 5 sec, if that fails a smaller number
>  	 * of even seconds,
> @@ -458,8 +481,7 @@ static int __init octeon_wdt_init(void)
>  	max_timeout_sec = 6;
>  	do {
>  		max_timeout_sec--;
> -		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) *
> -			      max_timeout_sec) >> 8;
> +		timeout_cnt = ((octeon_get_io_clock_rate() / divisor) * max_timeout_sec) >> 8;
>  	} while (timeout_cnt > 65535);
>  
>  	BUG_ON(timeout_cnt == 0);
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
