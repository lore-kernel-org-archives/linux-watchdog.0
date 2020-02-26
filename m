Return-Path: <SRS0=Pzm1=4O=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD25C4BA10
	for <linux-watchdog@archiver.kernel.org>; Wed, 26 Feb 2020 13:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597F624683
	for <linux-watchdog@archiver.kernel.org>; Wed, 26 Feb 2020 13:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgBZNj0 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:39:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:24376 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBZNjZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Feb 2020 08:39:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 05:39:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="350390585"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2020 05:39:21 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 26 Feb 2020 15:39:21 +0200
Date:   Wed, 26 Feb 2020 15:39:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Martin Volf <martin.volf.42@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog: iTCO_wdt: Export vendorsupport
Message-ID: <20200226133921.GS2667@lahna.fi.intel.com>
References: <20200226132122.62805-1-mika.westerberg@linux.intel.com>
 <20200226132122.62805-2-mika.westerberg@linux.intel.com>
 <5e56f8b1-c411-69bd-6e02-c0dde3db69dd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e56f8b1-c411-69bd-6e02-c0dde3db69dd@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, Feb 26, 2020 at 05:32:40AM -0800, Guenter Roeck wrote:
> On 2/26/20 5:21 AM, Mika Westerberg wrote:
> > In preparation for making ->smi_res optional the iTCO_wdt driver needs
> > to know whether vendorsupport is being set to non-zero. For this reason
> > export the variable.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks!

> I assume you'll send the series upstream in one go (through i2c ?).
> If not, please let me and Wim know.

Yes, I was hoping that Wolfram could take these through his I2C tree.
