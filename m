Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44169 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbbCIP2o (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Mar 2015 11:28:44 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YUzbo-001uUj-7y
	for linux-watchdog@vger.kernel.org; Mon, 09 Mar 2015 15:28:44 +0000
Date: Mon, 9 Mar 2015 08:27:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	david.paris@st.com, a.zummo@towertech.it
Subject: Re: [v5, 1/9] mfd: dt-bindings: Provide human readable defines for
 LPC mode choosing
Message-ID: <20150309152758.GA7497@roeck-us.net>
References: <1425492398-27340-2-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425492398-27340-2-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 04, 2015 at 06:06:30PM +0000, Lee Jones wrote:
> ST's Low Power Controller can currently operate in two supported modes;
> Watchdog and Real Time Clock.  These defines will aid engineers to easily
> identify the selected mode.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
