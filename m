Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB238F95A;
	Mon, 30 Mar 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886529; cv=none; b=UbYihZkpTYslF3cxWTKarAALBIuM95GvKlBQlZpzFAAaxXXiHc38U54CN+DtMqd8hoH6h9gHyNiuXWzSyXCrKb1bAIcpbLET1ndEzZ+NvnQO6UmL9l6jflpFZVt85bnaedGsKfHfOXTAm5Z2n9/+ft8EnzDOPicFefJRSLg9/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886529; c=relaxed/simple;
	bh=bZxOWxEEFoNP8nwfQq1+L7YDB73ALBdiVv7DuJbo8fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oldUwanpPXFb6cnJsTI+popls61+Qse0UeNXhETbjvBlw3BNYuECN05Hd2KRLzh9ORtUcwH3T9Pnpr8Od1d5XkaTxX5+Se/yhEOXUbbj3eFIGLaTzwl9hre3CDX07yy1Dn5SwnuW50Y1WfWz/yCMMSMq7m2gYTldazfj0Mv4VyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/LNNBR7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/LNNBR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA5AC2BCB3;
	Mon, 30 Mar 2026 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774886529;
	bh=bZxOWxEEFoNP8nwfQq1+L7YDB73ALBdiVv7DuJbo8fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/LNNBR7kd6BoJvzcBEHnSAfhE6n/e2IlcG1I11XmadPHRxu7rnVdCAJZ1sNkGk0K
	 wohtE6H/lrAD4UayZWL9H00uXp3l5QqqK3FvrLCmFKGQTpU0035jwU47pCqneR/Bey
	 pgx0TQb2S225wZh+exH9yMw8U44RcyvJOPawAovoSJTrhP12OhMNQ5eu76M57TxOmR
	 7xgTPT6rz8e9Vti2wOIyHBAB0ykTwNut9FuJOU3ttLeuojLBaJc1YEzkdLbqb5PYH7
	 G1/ztmFcjlMm3Nbej2RZiFYGkUX1ZOzgq0TYevGQVo0Kw1OsnAtnvs4Fx79BVR2Inx
	 bPrIz7Y3KxjBA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v8 0/2] Add support for Gunyah Watchdog
Date: Mon, 30 Mar 2026 11:01:27 -0500
Message-ID: <177488647785.633011.3268352623614004436.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311-gunyah_watchdog-v8-0-4c1c0689de22@oss.qualcomm.com>
References: <20260311-gunyah_watchdog-v8-0-4c1c0689de22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 11 Mar 2026 11:16:29 +0530, Pavankumar Kondeti wrote:
> Gunyah is a Type-I hypervisor which was introduced in the patch series
> [1]. It is an open source hypervisor. The source repo is available at
> [2].
> 
> The Gunyah Hypervisor doesn't allow its Virtual Machines to directly
> access the MMIO watchdog. It either provides the fully emulated MMIO
> based watchdog interface or the SMC-based watchdog interface depending
> on the hypervisor configuration.
> The SMC-based watchdog follows ARM's SMC Calling Convention (SMCCC)
> version 1.1 and uses Vendor Specific Hypervisor Service Calls space.
> 
> [...]

Applied, thanks!

[1/2] firmware: qcom: scm: Register gunyah watchdog device
      commit: 07b9712339e3ce1d183adef996c0f317adc9848d
[2/2] watchdog: Add driver for Gunyah Watchdog
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
