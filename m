Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:59079 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab3LURzb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Dec 2013 12:55:31 -0500
Message-ID: <52B5D612.806@roeck-us.net>
Date: Sat, 21 Dec 2013 09:55:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>,
	linux-watchdog@vger.kernel.org
CC: wim@iguana.be
Subject: Re: [PATCH 1/1] watchdog: sirf: Remove redundant of_match_ptr helper
References: <1387614673-2740-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1387614673-2740-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/21/2013 12:31 AM, Sachin Kamat wrote:
> 'sirfsoc_wdt_of_match' is always compiled in. Hence the
> helper macro is not needed.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

