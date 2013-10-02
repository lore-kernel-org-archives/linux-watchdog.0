Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64903 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab3JBPQe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Oct 2013 11:16:34 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so1015260pbc.36
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Oct 2013 08:16:33 -0700 (PDT)
Date: Wed, 2 Oct 2013 08:16:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [3/3] watchdog: sunxi: Remove redundant of_match_ptr
Message-ID: <20131002151628.GA14808@roeck-us.net>
References: <1380516173-6974-3-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380516173-6974-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 30, 2013 at 12:42:53PM -0000, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
Acked-by: Guenter Roeck <linux@roeck-us.net>
