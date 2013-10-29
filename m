Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39319 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751774Ab3J2Hqr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 03:46:47 -0400
Date: Tue, 29 Oct 2013 08:46:46 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: at91rm9200: Remove redundant of_match_ptr
Message-ID: <20131029074646.GC19704@spo001.leaseweb.com>
References: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Your 3 patches concerning of_match_ptr have been added as a single patch
to linux-watchdog-next. I also adapted the commit message with your the
description you gave later on to Guenter.

Kind regards,
Wim.

