Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53445 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbcC1WWg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Mar 2016 18:22:36 -0400
Subject: Re: [PATCH 09/17] watchdog: qcom: add kpss-standalone to device tree binding
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
From: Matthew McClintock <mmcclint@codeaurora.org>
In-Reply-To: <20160328181544.GB29820@roeck-us.net>
Date: Mon, 28 Mar 2016 17:22:33 -0500
Cc: Rob Herring <robh@kernel.org>, andy.gross@linaro.org,
	linux-arm-msm@vger.kernel.org,
	qca-upstream.external@qca.qualcomm.com,
	linux-watchdog@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <5E6274D4-B437-4ABD-B5A7-CCB38F282309@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org> <1458770712-10880-10-git-send-email-mmcclint@codeaurora.org> <20160325141521.GA12357@rob-hp-laptop> <0F389D09-1165-4686-98DF-0265351A086A@codeaurora.org> <20160328181544.GB29820@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mar 28, 2016, at 1:15 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
>>> What SoC(s) is this in. Use SoC specific compatible strings please.
>>=20
>> So ipq4019 wins the race because we are the first to try to enable w=
atchdog for this block?
>>=20
>> qcom,kpss-ipq4019 ?
>>=20
> It is a dedicated watchdog block, isn't it ? "qcom,kpss-ipq4019" woul=
d not
> refer to a specific block. Devicetree maintainers may have a better i=
dea,
> but it seems to me that there should be 'wdt' or 'watchdog' in the pr=
operty
> name.

Sounds fine to me, if no one has any other comments I=E2=80=99ll use th=
is one in the next spin of the patch.

-M--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
