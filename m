Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460290;
	b=k+FsK+p47hIdMdJNX7L4fg+LZqf26dn2dP06E6r0rkClk8Oi5zDM/NXQDoeMRpifEc/a
	 mQNCSRQ27HlvbYjPcVUXSC0j94FX8kC4fvjqRRSVpcr+jyRB0nfsNnQbfU9UelaX5LRI2
	 TrOBdkU/1Ie6UO5UY2kKKB5vcVDSu+6IkvzSDzrs0GhspGOGdDo0YVLT05XTDdQA96vZI
	 0QcU0Xwzynep57tTF6AaYPIQeIgqCq9+RltfxG34ZFQkO48czFMdMcgpReIZLF8wZR4Ne
	 2Fq+D7xd1lf2HQtyQKu74+AskBc0fK5yeqLFA5n4HTWG+OcPkF8QI9Pm3wIAdA3feKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8Vg2HGC9f0RLK6KKMp0Lu8393a2H674YghRuAU4vlpU=;
	b=TKO/bMYK967lkDXLMtETFtEpc3dN3qvM4WLtnuPdu0j3m6c7zhqkrRioSX2uNiX0W44C
	 NaOWtLnMDQ+HPPYjWBY8XNqBkDXPmhjMfp9Bv4inP91IXrcuYERC6/p122V6tvua9QVda
	 EqZWtnI3kR/rjMVRWtJTyjz0hFoUBEpfthvauDQtUJPHN+MmeP+ystCd00GFvk+erAy+X
	 WeKRrOYOR4LQ31vy1y/S+AEEcThsyzlWXJtU7tAVcdJZ3imXECZEYIylRAhT0MhTkN6VJ
	 sVL98l+PQRKZSsh2GwwdA7EcMKSR/uIPzIIudkWE+6y9zjSTLYzxBZpbrBuTNcsT3oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P8ClSeiq;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598C606A31B
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B598C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P8ClSeiq
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15354aa70e8so3037720c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460289; x=1793065089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Vg2HGC9f0RLK6KKMp0Lu8393a2H674YghRuAU4vlpU=;
        b=P8ClSeiq8iS2sLn5peXIWUrqLR8crS2ZbRIPFQ5r3UJoEOAy3kjbeUGU26ax0TW2vq
         M/VWc0S7TLRXwewbaBB0KXRODfGmMO4tM4luke2JHR2duix4LJ77dgPVxn/Fqq+WGYu4
         i2YLNUi/tFcRHmZtyqtwLpHEcMqeOyGD6igSrZ1Tki41ViKJ2IpD6nKi30soM30Co+vc
         3tZ48V/eBWE//1mWWvEH20OsbxLQ93KVy5A3pfmEWQaqv2RcbICpMieGwdqcsaIShX+2
         X39+mSi7/W0HTIMuO9ZGpGWzpFboaZzULMxmZp1zJAf0Fc6flUVOcpBqZHePvRvLvaFS
         +Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460289; x=1793065089;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Vg2HGC9f0RLK6KKMp0Lu8393a2H674YghRuAU4vlpU=;
        b=OP2JLF1TWoEt0UJY2TVg5Qz56Rk6dkEJGAW4UWBLeZxgGBvm/G5tidC/uwsQE5z1xK
         bLEaX0Q/0uk3b50Gfl/qIcALc2nVHom/Ge9WBbSg8P7Zh9qCq2wuvdvmyUhluZ9djR8A
         m9Gw94F4g5a8MZAf4JIfgwNvLmRLYE4DuTjSb5hNxfR1pYHExoFxkoBuA3IdwomtnGSl
         39nGDKLxoYsTG3xbo5EEpqybbviXFMIl2KD/SlCgI87mNi0cnAqo2QQ1UdPwMsyev7q+
         CaIDeitmZKl6MevgZivsBGrzcu2SOMXNubJTpUSri9iIMlow6/S4gWDKtDkheFWpLSEd
         h0CA==
X-Forwarded-Encrypted: i=1; AKwUvBzMBEluMm0BcsFtk0wZBydABMxLC/sAhBiJluhA9lTVlgoH3y02EyNdFDMSUdZ5huERLNdpROJNvbfkb5cl1g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJERu4MIaS/scI7+VvFvIndT3ybiZxL1DCXl6P7SGIALGMaA5iH
	6MnRKf4gPiQcrAUHeEeLP/jfNAYS8rgvtXONZrsrrYBcV5QTjmsRGIL/
X-Gm-Gg: AYBFou2uvoqEDl3wymikCEha7ZSkjzn2yjPUK1+BEYdBBirGlr1OYU2+9IxX1Bcu/e8
	hO1O6NRL0n765IWCRPXYSq/9TDtu0a79Vld0NMhHUcwzLf1DIaqRTsV3yfHHg1Q/27txW5FGtr7
	56eja1f2Iz6ZC0i7ewY4cJyKQD4V9xBBYH4xWDBALBxdKHrUQdiNmmqTSXBPJBSK7ggyoNiZBA6
	fXxrEpCKkT4ahdZzILLeELN0e+8Juw1rNPPn8s/7uQ5SeY0t3DoqG5xa9NsclAg1BHKa9m7XX5P
	20PPgunvWEb7YDtUSgyZfxE8rzY0ncIzx9GqylYBXhpsxL6T+jVJDh5I3CY4R3yAtzkhCbChsJN
	/uTwtLwm1NNEJiheJoto5cK8nknPxi1B1+HYa4gL9MEAQgGjj0e2DHKS/qwd6E5duRn3odO40zR
	KpC/oJmtVQaOJtttfORfDtK3lvImdP/2op96o/Nw52IJ93wkq0cA6NDPaz1AkoNqO3yUQgmKEFP
	+O3oraX2Xnn
X-Received: by 2002:a05:701b:418a:20b0:187:eb7f:bb4 with SMTP id a92af1059eb24-187eb7f0d0amr9277157c88.46.1792460288841;
        Mon, 19 Oct 2026 18:38:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm37629861c88.0.2026.10.19.18.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:38:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:38:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, manuel.lauss@gmail.com
Subject: Re: [PATCH 1/5] watchdog: gpio: Allow devices described by software
 nodes
Message-ID: <74cb726a-b36c-437f-988f-c4f3bfa0a7b4@roeck-us.net>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <20261016221617.2223004-2-f.fainelli@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016221617.2223004-2-f.fainelli@gmail.com>

On Fri, Oct 16, 2026 at 03:16:13PM -0700, Florian Fainelli wrote:
> The driver reads its configuration through device properties and obtains
> its GPIO with the descriptor API. Neither operation requires ACPI or OF,
> so allow the driver to be selected on platforms using software nodes.
> 
> Add a platform module alias so a non-OF platform device can also load the
> driver when it is built as a module.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.

Thanks,
Guenter
