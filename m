Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A48384CD8
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945059; cv=none; b=tQhI60UhxrkvOuwSURQgc7s63O7TbtzCw+z3Qai8FywQ3Cdc1gDee53QVclYBiJhlBpwVTp8i04zOSnZVbKEx+vMH4ZHVyQSIntFMFDX1/MG8CBqFi++v66VB+LSybdNn4bMXAxprjZUcxD0vb+C+c7vW/OJaL/RivzCaQn3Jc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945059; c=relaxed/simple;
	bh=jkh7GOY75o5tAaXUkftrhl52D+BNlEhyRCLBf/ASOeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOokF/YbdrBzNm9GccjNX+4aPOnfuJ8YZZIrNUyMqzCRZRWL1HkymEm41yrvy1EY/W1YVJs4423VXk8BPWGumf92s9sLGoUvTdeTT/PLXSeveCG/O8L05M/oK69w6FgYDwganpbhWl7B+IVKVKD5UM9KwFLf8hFTxu2S84f3F+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLBXYqpw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLBXYqpw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so38964045ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780945058; x=1781549858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaO/mnGWwmDdVX0PNkKLhLRU5rJova1lSZQcYIwukqg=;
        b=tLBXYqpwvzzeORIgD+RSeHk79ReRoi/RL8yF2AloxSemiZu341e/xxSYoRZ36rRHdD
         O5ZKAQGACrnieClh05t0VAPWboVRtnKLL8tf4TzbB1jfwIpKtYB7q1ziWeZDCzEBkrKd
         j2d2jIUj2guVapFkTWJlE0OdhgeSvXj5MVL1PBD0RZdXqHUs0OV8irH1FVU5YEy9h0R5
         h7i1GHEnHGmrD37Ty0crmjxxM7WjMhZMmXXgW3FDjbH7YX2raGtDBULJ6bnDrAcWKVWB
         mM/nQAvTUWWqky4LSgHCOm3I+zZ1KF9Ciok7v2Q+z93Fdvg1N+45R1DN++quE2k0X3EB
         cgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780945058; x=1781549858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RaO/mnGWwmDdVX0PNkKLhLRU5rJova1lSZQcYIwukqg=;
        b=lQjV1rS1mWqRiqS03aOSM7ZDniZZKnzhVm8sPsuyT3k8OSGmoaPAtnTItlXzXqvuyP
         2UC3opc6FEngdneHjW6+RoDilyP16FwSSmxhzwTu47mXoK5Md4sLPhZsV5QR2xPggqM7
         K/isRSTwfYRZj2PlnJGT2JXkw2sc0U+wbt0BwFfGMEz78pl4n7hUPu+Ro/cd2RCAbRN9
         uzysIe1gwE8GoyQABk3tsHPtpScPRB32vimhe0WsyBQG6zBHYSAI9y5i1QlqyTtSDO4H
         aVeZa6/+C4ky9YUG1LRP1KeFH6/UK6eJXFqIpTrHCikr+v8wNYmmTQfCHr9C7PEANCPw
         eCMg==
X-Forwarded-Encrypted: i=1; AFNElJ+oSN0J90KWW/4/3MkO0tSnQmR50RTsxg+dqpgIGX/ddqbCeJEYxTVBUw2QanELw+Z/b+NOcKkXtcHVHuSN1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxlWV49kLHFuiUatsQ8L3Vp1ss8MldbOrDQA+QxLKbyll6qKb9
	DUJTSJbeFlSBFbvFUsfKRiRqb58+AmJiVtyu1jlZ8kiG+oX6hv7XAGr3
X-Gm-Gg: Acq92OFI4gvtjisnsn/vTuqra4HXQiyrRfQ99H88+UnOoxdRCNp2d/QcrSBWxRzfqsN
	Frtn7SgAt98sFw+HBVZmkADJe+qoPOJfrvGC/ZEMfwvrXx0TtA/A8K90BMHmNuIuC0n1qCFf0I1
	169hAXuQrRqtzXeqJ3U+kUqrI22ZFXOnS7aWBzGO36WU7AYiJIYAJYyP+eOcz+kA1ImQc7Zh1Tm
	nWokR9cZKTn0AgZSLZ7U436YiLoTgi2fdugknrIOg69SLyoRZ3VSDGCMB7hh5BBs/8p+ZmAt/P0
	Zippksv3X0V0q5vbIMmWoqOcPTjZV+OrjWyDT9R5Gg64Fs/uKOjEGnvJ97gBnRY+QjerzZiap5r
	/D3IcdjKY35sxoQYo+/7rJlzzJCbaHlsd5+yitEcMbjmtZECQSkIikkSpz4coPkYuCJ0PcUYjFm
	kPUodaMKnkQNqOZgZXBmjOnid2OKE1FOlfbRAnUCNjgZg2kKk=
X-Received: by 2002:a17:903:2a8e:b0:2c1:20fe:9d5a with SMTP id d9443c01a7336-2c1e83502b0mr235904785ad.35.1780945058014;
        Mon, 08 Jun 2026 11:57:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c249aeb62csm66783875ad.68.2026.06.08.11.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:57:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Jun 2026 11:57:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: unregister PM notifier on watchdog
 unregister
Message-ID: <06cb19f0-1e85-4f82-8679-7f56571fe847@roeck-us.net>
References: <20260601192005.1970805-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601192005.1970805-1-dbgh9129@gmail.com>

On Mon, Jun 01, 2026 at 03:20:05PM -0400, Yuho Choi wrote:
> watchdog_register_device() registers wdd->pm_nb when
> WDOG_NO_PING_ON_SUSPEND is set, but watchdog_unregister_device() does not
> remove it. This leaves an embedded notifier block on the PM notifier chain
> after the watchdog device has been unregistered.
> 
> A later suspend/resume notification can then call watchdog_pm_notifier()
> with a stale watchdog_device pointer, or at minimum after wdd->wd_data has
> been cleared by watchdog_dev_unregister().
> 
> Unregister the PM notifier before tearing down the watchdog device.
> 
> Fixes: 60bcd91aafd2 ("watchdog: introduce watchdog_dev_suspend/resume")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

Applied.

Thanks,
Guenter
