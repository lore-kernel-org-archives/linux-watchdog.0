Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34830 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbcB2E0g (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 23:26:36 -0500
Subject: Re: [PATCH v7] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: wim@iguana.be, linux@roeck-us.net
References: <20160229042039.GA29582@sophia>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Message-ID: <56D3C87A.8090600@gmail.com>
Date: Sun, 28 Feb 2016 23:26:34 -0500
MIME-Version: 1.0
In-Reply-To: <20160229042039.GA29582@sophia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/28/2016 11:20 PM, William Breathitt Gray wrote:
> The WinSystems EBC-C384 has an onboard watchdog timer. The timeout range
> supported by the watchdog timer is 1 second to 255 minutes. Timeouts
> under 256 seconds have a 1 second granularity, while the rest have a 1
> minute granularity.
> 
> This driver adds watchdog timer support for this onboard watchdog timer.
> The timeout may be configured via the timeout module parameter.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Changes in v7:
>   - Make sure timeout member is in seconds resolution despite minutes
>     granularity

Oops, my apologies, I sent out the wrong commit. Please ignore this      
version, I will resend the correct commit.                               
                                                                         
William Breathitt Gray
