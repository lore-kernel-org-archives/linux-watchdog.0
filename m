Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B65867C4
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988071; cv=none; b=ZgpceiQ55AetVF9gijcP/+SIht9WACRWvTNOoDvjeE1UiwNMtRx3DvWu8OpK8/rPCoBLWDfAZu619ZPgTfVoKhjBTBEDn26W0UiR1twp9JR4Rcc1dUaXoGo5JEJoh3xg9JZvyTbD9aFskUm1/NBjr1IdlcwH5NiLYHPd+hCyrKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988071; c=relaxed/simple;
	bh=8k2rxuvEKvp/msaM++ohWRokfd4pezuIMblVCzlLN54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeXYIWSHuOaF5UKzapAy+/QP/eQZ05xu5hFaYTDPPdKqBisrEhZrbhu0w1qntd7/UIcwWpGAvbO0F3Ct8+9k0ufXWKdEDgEK5i+GHctzaYzPoG4txmWNR8V8/IJRbPrCN5j5zcMYWRsuw7lQZVmqAEapRPZKhvbKVw9zNs0w4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq4Utlph; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq4Utlph"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbee846deecso225684a12.1
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 14:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988070; x=1789592870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kFArVIda1wvoblNEqEkcL0MbDi6T0NMYEvB04Xo/oDU=;
        b=Iq4Utlphn0SHrqTJ5fkQQEayvEMF5LSOkSs7bA/7RVon0EzCu6ZeSG82lkzZtpT1n1
         +J1m4QuOYrBnA7qOVSgFAxKBQOcV75mUFwrkY84u53+VTw/+vhECz8DGJXbYqGGsekLl
         3YTxdtATAwglI13kxmn4c0fNIA+LeUjFVBFSWFY3Xmf1gGszZmP/WikxenZocwNi2580
         mRopzArPnDe3LNIyKx+IrVBoxhic10UxSYPn+wT8yp1cFyLxx4nLPA4fIydARD6zJuWq
         MDiK5k0+k///BhLK2s1fgo9HOiSJegx8WS9BMZI+ulSfhTvxrpkrNBCJCssNI65qwGdw
         gL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988070; x=1789592870;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFArVIda1wvoblNEqEkcL0MbDi6T0NMYEvB04Xo/oDU=;
        b=iRYXSP7Qdxlx9R35LZuGnQBxOXw1BWJ2ha+9rVYto4FqNP8QmmE53ExoMkhOpUPrBC
         UA5FU/oIiEZWvPH1IjpP6iJgtGY5eks2SWK238AFresX3YGbhTF59enOMOyb9FRknHPG
         s/wtEsaDuS6MIx1ahfmjFI7aoKAe5j3Wx/15jV8gOKlwRM4BaJt/AZO33aI0czvWmf3g
         bidzw+xWHdB95eBULOtDQ7IQcqbewyj2Nb3fk2bkSGLEXjaqih2LUNdL0017EArna19f
         gE7oxBSPlcyNjihnRBWTbDi4U17esp4N4EtpFlAWzk+mkCoDvOni+3FjWVaM2wIMH3Xx
         rd2w==
X-Forwarded-Encrypted: i=1; AKwUvByvFm1ZcaI+eLqLGrEoMIXdWaDV4nI/1+la0nBsYSWMpmcOFIes6P45xM8wfczxUC2zaLXcPAWb/xJeg+fAgw==@vger.kernel.org
X-Gm-Message-State: AFuF++lRPrIeBPNytY133NgBDw/rPhcKLDymT3gfeiWq9/sAB/eSd/e7
	354wZFCPKveppsklY6QjSScLk8P0DSc8DkI0f901nttB2zAT5LzxPGh9
X-Gm-Gg: AYBFou1CK2MO8Tzuw3x2z1FJSwEj5ap6xdKeKzvD3KLyy8MdwOS4Q/pOCWBnX9PYDSj
	zRunAfoD788CYvjM57Fl5C6xLzAIvcfWI2QHMY1EasfFOsCh7rP2CpVEnVuhslqelKGjrrkY4Ea
	y1392xegqZRSaffdKQkkJZGxJgDQOkJtxzmlhq3G1pp/JzeNeJuQAPI7pUy2Yr6cvT5204ysV95
	Bu8hAXicpob/SC0VSiFLc1+rOl6SlxbnL0N4GPvMTsAJrV3Q2uZUG96o4cUup7jQ9uHZDpXR/jk
	4F2KjNZ8H1LtHUxux5c6N2/j+XGv9zjTDmOnVt8kffdANZBFFv+rm273DPRdIJ5eJor7n4V8f3G
	EMmhtFyda/MLL3d/obNXTsaeVOgYYMf64x+T44SGhk7fOU9qYJ42gQaF9Ot4AcqswFbyQIJfrNc
	xdUIAY3gwUXkC8ge97kVG2CCeUqDE8hAiQqGKIj5EHxYsKJhII8w2wicOcrArSc4MqapXJeCryP
	xSPFDk1+a2V
X-Received: by 2002:a05:6a20:9630:b0:3cc:ebeb:3efe with SMTP id adf61e73a8af0-3da39ee18ecmr57919918637.9.1788988069777;
        Wed, 09 Sep 2026 14:07:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4a636abd1sm1300347a12.11.2026.09.09.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:07:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 14:07:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] watchdog: msc313e: Fix NULL pointer dereference
 in PM callbacks
Message-ID: <f2cdc4eb-254c-45fb-8801-4238a2b814d3@roeck-us.net>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-2-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828161348.13212-2-tzungbi@kernel.org>

On Sat, Aug 29, 2026 at 12:13:40AM +0800, Tzung-Bi Shih wrote:
> msc313e_wdt_probe() doesn't set the driver data for the platform device.
> As a result, dev_get_drvdata() in msc313e_wdt_suspend() and
> msc313e_wdt_resume() will return NULL, leading to a NULL pointer
> dereference afterward.
> 
> Set the platform device driver data in msc313e_wdt_probe().
> 
> Fixes: e9800b799464 ("watchdog: Add Mstar MSC313e WDT driver")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,
Guenter
