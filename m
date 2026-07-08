Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A137F735
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519335; cv=none; b=QbRzBa4NczCu/XN2VM7EsKjbk9TyOaU+MV1Why7pUNIBFysjBFmqeD85sOKAyzYS91DqfMq5MO9HDwQY4xPpHqOoEW3GEgXF0wTBM/N207oXHtgvS+BujB8uXFisOAO/RprpXWF20yrIFCgV803PayMYeyz9deTkpu/e3kWyjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519335; c=relaxed/simple;
	bh=meSo52nhLPyPPfpjrchTWDvrZuj7Mfl5n5Vf1VCL444=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC8oT2qYdmcpy+u8qGDVJzZmdWpUZ10AlpryMSZFeQ80MRa7E6QJFaxEyGqnRk76HvH5qG9zr6Cd8gMBInuRGB7JVYYatdOcW6IOlE5QLQ2Xre/w6qPIoSQn3i41/4rP1MJ3NIHdEWavav8wJhjquxNrplOZ01y24maThmunIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+y957w7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+y957w7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84847f60deeso495763b3a.0
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Jul 2026 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783519334; x=1784124134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91Xo5Ef52/IPXALe4dDwTyqAVYQ8//PzAV25JhbVrxU=;
        b=c+y957w7OAUYpl47i28z5/GCpG6rpLLo5YA+yTT1L2jNv4pcyJsJ2QRmiH6h6CUJSd
         bH6NXYYpnxDac5rTml4YLanFR9xUMA51v+pxbUQwSfaZPrOiPbYHvHhoBodKWVzeSElz
         VVfVLzNCuqzWHS4iW5pk8tpxA7UosrQv0WpU6ffziY+cjGjvRURj1sCINkwXgj/X0zfb
         zGvUYk25F9WNBBIgmiXE4nNlnIJrIEz9eOK6oDCKrsF3cb59SZsamoIiD4xxoLtA//ls
         iK3F9qTrf+iIlLfILnCBtG91UxFDPOupJpZSFes+1nkjrDmnQpoTzaqPmlKn2WCs7AW4
         yTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519334; x=1784124134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=91Xo5Ef52/IPXALe4dDwTyqAVYQ8//PzAV25JhbVrxU=;
        b=d+G+yfCHL/RSB+QbdkKS8nXk3baPsJ5ScuWDmOJn/jfjyhapZIi9IVllEVN/UjNR12
         Qqnv+Q017YoZRniLMtityUj8sYnH9NhnNyE+5IsHhzQDharD57H8lszRZt/1It5x2UOe
         DqguFPNajivl/gzCo6uaj9TKGZzehTeNLgrxqrAfw7fj5XALa8ODHRVjrRgVm3DY/byu
         BkTPkuqjyxXvbN6Xj3tzhdt7GBGiuD80ioN/36VXgy+UeRSurWfniCaputVntRbvak8t
         Psj1BQIBJI7CZ1/pgYYR1jFBaACsXP8dGhvQyEQGc2RW1/jtm9OYjr7GoTZFZzDBAkd3
         gItQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpvv1Z2ZMausq9KAmQPvVMjTunkDQ5TPsRm+q7rx3UZBifxy30vLg/0iTMYb9lHyorJZq1KvIKJl+ljVr3eDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQaGx5+Uwm1PJjiTGPevlqe6FVGoNom/Tu8ZunpMIcdZF394pe
	8uszjMNRM/JW60USQxWdzArDcIytuihk/xzVyZL5yvOSneZMzqVqogr8
X-Gm-Gg: AfdE7ckAH7vBaeluf+DvXBoP/Uc55/bNKLKU/i+Lr4KVLxVbwdBN8qxvwA5SEWDgVUy
	psiJBQhybZFaqdxkdYYb+mAKotQam4bMS6cddchJ0MISZjheLoYxFGAmE3xSPVkvT99aDW+fizn
	CKR6KiNHhIfpkLhkYD4h9h6X/8hyl7YKrYH87Yn97CK7IK+t17nYrwdHXkQK/VuZwMMxCtBzkJy
	KLe9znlsJI7CgVqVYrr9oY867gZeTgsJoep0osrY9MEz8OrTaQUMnnt0E0LLf5WlO5kbGOxN/5b
	Dns9pi21IKECyRvAKE9kdOcOHn32etWY+vSIXQ9howfr0jYFPnx7Uh2k3bwmjMHSDUCDKTJX8kb
	l0aenm9L0dLGO4sUryV3NDgOCEDUIjnobldlnnPX5K6V0J3h4hyFfVAXCemg0PoiBE+0FpGjY3Y
	obUm15yStOBAy0pzf1hjvVSttdYg==
X-Received: by 2002:a05:6a00:23d4:b0:847:9803:ec6f with SMTP id d2e1a72fcca58-8482f1ddd8cmr5998922b3a.10.1783519333610;
        Wed, 08 Jul 2026 07:02:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d44d48sm7155869b3a.39.2026.07.08.07.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:02:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 07:02:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, tfiga@chromium.org,
	sboyd@kernel.org, dianders@chromium.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: pretimeout: Add "dump" pretimeout governor
Message-ID: <f01a9377-6d7b-4c94-b9a4-3a3b46206cbc@roeck-us.net>
References: <20260707102105.3600275-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707102105.3600275-1-tzungbi@kernel.org>

On Tue, Jul 07, 2026 at 10:21:05AM +0000, Tzung-Bi Shih wrote:
> Add a new "dump" pretimeout governor that triggers a backtrace of all
> CPUs (via trigger_all_cpu_backtrace()) to the kernel log buffer.  This
> provides diagnostic information right before the hardware watchdog
> fires.
> 
> In addition, update the WATCHDOG_PRETIMEOUT_GOV_SEL Kconfig logic to
> fall back to the "panic" governor only when both "noop" and "dump"
> governors are disabled.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,
Guenter
