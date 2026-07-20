Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465342A144
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563885; cv=none; b=MBihbTGPXPTE5ZVqv6G7X1lN+VBxAkfI2kvlBTl+bFslrT5ga+AxDGDmg7b8CKysN+mF7uptHjnzJPi2mm65icKyM9V5eau4iswwpJEwA3NFM4pyBI3urnA12nsHHfk2E/znpw5vjFwFPpusf1EI2VbcOuERghcU1f+nr0ejC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563885; c=relaxed/simple;
	bh=vZjpn444Dr+n9sHS9FJvINtAEvVv2hvJQ0560E8hhgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klMMHNr6GFG3xwv3vrrNC0+zTOgPKTahk8fhy7QTVYC7cFLyMJPJbGEo5htY0YkjJslx5g7qPY3ggKFnskXljOE5OLAaOKvJItmc5rDoBv+Jn13QCC/tln/ipLRsZ4RW/MGeDkPwCjsb7N3dyWXCBMdRFVPv/g2CO+UU620BnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adV0DpAs; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adV0DpAs"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso6390627a91.0
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784563879; x=1785168679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9xxRXY8WEN0UqvALfUo+QgEc7p0+yzjzyNQ5kB5akAQ=;
        b=adV0DpAscnn60OPV4ssIBnmIro5NdkEphKZ35Y9Ayx8yamDO2bsnXMPp4l24tmSghC
         Cm61OgDX7QbuJEjgptRx/RLZlTWqH9suarmRHNWwOJqAEi0DEz5FzcNJujRhFY5/PfFk
         6PDcUQCIH6HpOM7qJwg8f+CzC8IFlVzblLVx8bYP+1G8EnFXrU+bpmaOpScPpmUe3qEQ
         loWPe5CfZK5RX0rt0ORujC8CJSKjGjKJZKra50rqBt/3cGVXXDbqgKY9LwYpMedMiqsK
         Jv4ccgEDNzgVe4k/dCOgsYX46imbogkq7h0Ie4rcuZF8FQ1g5nfAfYsVXCUcc7pskoC+
         8Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563879; x=1785168679;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xxRXY8WEN0UqvALfUo+QgEc7p0+yzjzyNQ5kB5akAQ=;
        b=pXRQ1++APqihAdovJagGKWCxHyBcayucXlrXtBI6LauliXFwEo7vdD+7AJfiduQ3Yk
         8I2m8zGFxYpG65PBhRKVN6gS46BPRIwITNGxNncH61Z5DU0pDOM+M2ql/7Vv1BY4H9Ot
         UjrKUSrm4+22mP19MsR+yNt16NVs4Qj+1nqblJPDvwgUFzRota+WPe9kfFxCHSv7SLhc
         F6NQXnT923mVOw9tkZh57s3xbLwAUmctH0Ovkx5Z9nGJVSD+ogup/iB8A2I7j5wgqOd7
         k4HNv/tlywgCsjISxhtZssuAUjz+KDB+R0tmfiFla9CQ/a0AakHkEo9Elyd2pOogTX6v
         PpHA==
X-Forwarded-Encrypted: i=1; AHgh+RpP6TGh5vt+z2+t+LxProO6nq0L3eRyg95dgX1am7Sja7W96hn8CxHBbt5ooVyCAfvxnvqfwm8RIXJBderYfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/Axx8KGFarJSDqdbNbwjKMJK4hpEM97ZYhHi7focqWsBqSzI
	CmNkTi6AN5nivjQxEN+/epk3cMZ0uEMZe2ZuJnUPT9bieHXFuWUg2CR5
X-Gm-Gg: AR+sD11CwktN0Skwdvu74AsHzM0FccnUtn9L4R54RdTOYD/XHmTSITxBU8drDnIGSuT
	0kXkkR5OTx8sG5mTpnrczw4+X+nR3zDGp/RJF9KOqErHyYDbLsNc+c5BYVPbW1oC4QKMItBHYAs
	rCHWHIsV20N8EfMjw8r8kVYkhCEE180avgWgmYY5sSv6tWVAANaabGizVvfJf4+YoA0tcdX4eDh
	QQ/qSnkJ2z/MFDOcjQ7CsGcul/SrihSSs8xLioMM3WDbKaWZTvNQr7zyTL10phZdR39YCeHZIqH
	DqPCore91ECFo2IzEYoadgV/3gSdbOWbeCrIWTEq5/rmYyqIEGCW7/yve+PwF4UOmJcpBIsUAVB
	OE8kOYuG67HVMxdcMraXm6CSV8vPjCpM0mmBZKxhMGlhcy//T8pvs7YAV6d+fO0x79X9COHC7iI
	mQTNJe3C+QCTSmpKM=
X-Received: by 2002:a17:90b:2c84:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-38e4b422bebmr15575435a91.8.1784563879361;
        Mon, 20 Jul 2026 09:11:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2c93sm34678064c88.3.2026.07.20.09.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:11:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:11:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: andrew@codeconstruct.com.au, wim@linux-watchdog.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, openbmc@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
	yuenn@google.com, benjaminfair@google.com, corbet@lwn.net,
	skhan@linuxfoundation.org, joel@jms.id.au
Subject: Re: [PATCH v4 3/3] watchdog: npcm: add bootstatus support
Message-ID: <f0a8a606-0687-4c3f-887b-ebb500e760bf@roeck-us.net>
References: <20260706144828.3517631-1-tmaimon77@gmail.com>
 <20260706144828.3517631-4-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706144828.3517631-4-tmaimon77@gmail.com>

On Mon, Jul 06, 2026 at 05:48:28PM +0300, Tomer Maimon wrote:
> The NPCM750 uses RESSR and the NPCM845 uses INTCR2 to latch reset
> indications. Read those bits during probe and map them into watchdog
> bootstatus flags.
> 
> For NPCM845, cache the sampled INTCR2 state in SCRPAD10 after the reset
> status bits are cleared so later probes can report the same boot-time
> state. Also report WDIOF_CARDRESET for the watchdog instance whose reset
> bit is latched, while leaving WPCM450 behavior unchanged.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Applied.

Thanks,
Guenter
