Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58769 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbaCJCcn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 9 Mar 2014 22:32:43 -0400
Message-ID: <531D2449.4060108@roeck-us.net>
Date: Sun, 09 Mar 2014 19:32:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>,
	linux-watchdog@vger.kernel.org
CC: linux-samsung-soc@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Remove unneeded initialization
References: <1393925675-21636-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1393925675-21636-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/04/2014 01:34 AM, Sachin Kamat wrote:
> Initializing clk to NULL as a reset/error condition does not
> help as NULL is not an invalid condition w.r.t clk. Remove this
> initialization altogether as there is no state retention.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


