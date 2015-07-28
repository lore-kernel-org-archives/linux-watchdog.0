Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37240 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbbG1JQ0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 05:16:26 -0400
Received: by wibud3 with SMTP id ud3so149996193wib.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 02:16:25 -0700 (PDT)
Date: Tue, 28 Jul 2015 10:16:23 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Lee Jones <lee.jones@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150728091623.GB2492@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150727153344.GC21114@x1>
 <20150727203208.GB23196@codeblueprint.co.uk>
 <20150727213236.GJ21114@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150727213236.GJ21114@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Jul, at 10:32:36PM, Lee Jones wrote:
> 
> If it's possible to split them up per subsystem, that would be ideal.
> Cross-subsystem patches are a pain in a backside.

Unfortunately that's not entirely possible because you need at least one
patch that touches both lpc_ich and iTCO_wdt when you make the
transition from 'lpc_ich_info' to 'iTCO_wdt_platform_data'.

And it's not like this patch series can be split up and taken through
separate maintainer trees anyway. It all really needs to go through one
tree (whichever one that may be).

-- 
Matt Fleming, Intel Open Source Technology Center
