Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802C38837C
	for <linux-watchdog@vger.kernel.org>; Fri, 21 Aug 2026 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343905; cv=none; b=GbuYZZ3aTPppwcQT1Y3prQntnRpDy8UXwvRSt+uy64wrg8Oed958DtqMlBQku7MfkrwHrGfMc3/HzLSKfT/+n2KN/jf6ny8aFNb6TNiQRar7gT/BUJOZaEqnoFtSUlw2hvSvD8EvyDMQVNEUGXIofRXyZBV1WjcY35Ql15NtHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343905; c=relaxed/simple;
	bh=qUoeO2faq/qjZDlb70Kp6jwtNfuXURILtwqXxPTJbfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT8Hj8FpqV0AdMId5VvWd9sGv9Szq9S0VPjLWtY5cHV36pn8JUTJUv9BIUP1yr3j6/Bh8t6fEJ/3iwHL4aLGulFOpI5Bz0UHzZ1E+TiHCiCJJYI8A8f/3BcHAjtnYl1iLPdaHFhArH5lEKbi3IaC+fTyBPrKT2u2GJOm//whX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwjSqYPD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwjSqYPD"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848761b5897so595300b3a.3
        for <linux-watchdog@vger.kernel.org>; Fri, 21 Aug 2026 13:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787343904; x=1787948704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mryiVXJsQPAfn16G5ANn/TmUWuuegZkOuiE8/arXclI=;
        b=mwjSqYPDtORlFP3e6P4wNnIExXsPPdJCsx69AAuFl+f3XfHgNOpRzLLZyZ1gsOonsX
         cjA9EkmWdMIYg6jUGVVuKtuhSFuw2n8FgWaFioaQsUq/mijRzDtrByEgf3+BIQUIx2VD
         7RpusIVO0vQnjyACI2JrD+TQyrCp88teKZV1raMTkkqn1m4fiYF8OFkBQK599MGlbSWW
         2UIpUqTOLoiToQtQlB7QRSxy9RN1nVShnYPY9LKedLmcPTrkCSIYAXSkAYIwvEpcQgC4
         1PvTtAs3JcPBFt1x1jPgYKf+mrOivMhPQbGbg7eE+3IXZNqvt35tJgnqRSbEYm3mnnrl
         2zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787343904; x=1787948704;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mryiVXJsQPAfn16G5ANn/TmUWuuegZkOuiE8/arXclI=;
        b=UomYOaBNZtW2r3XzLrzmrR1vyyi3sydAQPiQlNT3NWL1MwgH1U0UcUtpJTY4s/vkbi
         p4DSisPXPunZXiqgURy1uuOljjYU2/46oA3HZh0ox2NewCwSu1bGLlfnhXrZsbeBbmxI
         Ocqvldy8D4BYwErrXCGZyNnv4gAReJ17g/6LPd76jlY2vPFq1AC+Hlb3USOExFYo1Xbf
         B7WYPkyqDoNz+3/IJOUwUbkc/7+DrBoqTITo+M5F4c49Io32hPeARjXKc8D4Ca+36PpJ
         XiaYjHgr/M6+Eji+Rm3Q1MzCplfnOZ/slXb2m9JUsh44qToDM66rFrcCOkWSVdTOUXBd
         h++g==
X-Forwarded-Encrypted: i=1; AHgh+RrmA2wlJjVSPmOfQdYJpMYy+uEIGMQWQULRPDH0/ttS/KYdr8xRId/rsIIgNMaXOrrN7ds7wNFmjK/HsCfTUQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mNQckpSIf1SZ3kE2rO1JOu6utnCelIzwnfFjYqIqkUpGb+H3hC
	CG9uasc7oPRBB5q+4+rQT2wDFhWK+GuZAP/O9ZY4OF22AGVwKeBOcTEE
X-Gm-Gg: AR+sD10FAUd+yCgdL6QRZ87spWXzW51ziACrB3+PsATnM0Ru7PoumLlw1dR3N++wOdv
	RfudVE6pOYHibpNhZ/oj41GBhmpjFL2Gc3SrkoM/eaIT5Jdw13BvWYR898j+IxNmJZZkqCKR83p
	9t0tEnIkEclNmrrsiL41oIMwr2nXj6pZ3qsrcoqGiCarhKz3ow3GAGgs0HFV3D5BfIN/+PkeaU2
	AZeWgQFyp6Dl2FObg9aubs13tn+WT1ekxLv7FuISUcGEkX8fwI0Vnu6ziE4tBuSqutX4NNhmDaC
	2kieXhhDspCsTLe5jBA7rh34dCSJ+f3l6KWLg78Ju5Q1FOk+qBRtn44EwYGCifuTfaveeifgQhh
	GKFBGPD0xFCz90VRDYbO7grVu7UE25rTLRStpwvfcVObCOTqYdjtRoRIQPW4DBap0LwE0yz910o
	B3f1bE6GoUWvAlKJmAsVFaQ5rRKQR9pQbcy3nLPL8GHzADFOh+5uIHZ3rQWqME12Xry0qxcp59z
	bXFlqmdD+tw
X-Received: by 2002:a05:6a20:938c:b0:3c3:9c4e:de3a with SMTP id adf61e73a8af0-3cd2febd396mr15299852637.6.1787343903678;
        Fri, 21 Aug 2026 13:25:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3cde4sm33854320eec.4.2026.08.21.13.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 13:25:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Aug 2026 13:24:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Zexin Wang <ot_zexin.wang@mediatek.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	light.chen@mediatek.com, Fred-WY.Chen@mediatek.com,
	Yt.Hsieh@mediatek.com, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4] watchdog: sbsa_gwdt: add early_enable module parameter
Message-ID: <9cd5d894-6a70-4d23-a477-71568c032562@roeck-us.net>
References: <20260817023838.6459-1-ot_zexin.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817023838.6459-1-ot_zexin.wang@mediatek.com>

On Mon, Aug 17, 2026 at 10:37:49AM +0800, Zexin Wang wrote:
> On SBSA platforms using standard UEFI firmware (such as EDK II), the
> watchdog timer is often enabled during early boot stages but explicitly
> disabled by the firmware before handing over control to the OS (e.g.,
> during ExitBootServices). This is done to prevent unintended resets
> while the OS is loading, assuming the OS watchdog driver will take over.
> 
> However, this leaves a protection gap. If the system hangs between the
> firmware handover and the userspace watchdog daemon startup, the hardware
> watchdog will not fire to recover the system. For safety-critical systems
> that require continuous hardware watchdog protection from the earliest
> possible moment, this gap is problematic.
> 
> Add an 'early_enable' module parameter to allow the kernel driver to
> re-enable the watchdog immediately during probe if it was left disabled
> by the firmware. By setting the WDOG_HW_RUNNING status bit, the watchdog
> core is instructed that the hardware is active. As a result, the core's
> pre-userspace handler (controlled by 'handle_boot_enabled') will
> automatically issue periodic keepalives until userspace opens the device.
> 
> This bridges the protection gap seamlessly without requiring firmware
> modifications and without risking unintended resets during kernel boot.
> 
> The parameter defaults to false to preserve the traditional behavior.
> 
> Signed-off-by: Zexin Wang <ot_zexin.wang@mediatek.com>

Applied.

Thanks,
Guenter
