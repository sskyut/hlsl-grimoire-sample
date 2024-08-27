#pragma once

class RenderContext;

//���_�\����
struct SimpleVertex {
	float pos[3];		//���_���W�B
	float color[3];		//���_�J���[�B
	float uv[2];		//UV���W�B
};

/// <summary>
/// �O�p�`�|���S���B
/// </summary>
class RectanglePolygon
{
public:
	/// <summary>
	/// �������B
	/// </summary>
	/// /// <param name="rs">���[�g�V�O�l�`��</param>
	void Init(RootSignature& rs);
	/// <summary>
	/// �`��B
	/// </summary>
	/// <param name="rc">�����_�����O�R���e�L�X�g</param>
	void Draw(RenderContext& rc);
	/// <summary>
	/// UV���W��ݒ�B
	/// </summary>
	/// <param name="vertNo">���_�ԍ�</param>
	/// <param name="U">U���W</param>
	/// <param name="V">V���W</param>
	void SetUVCoord(int vertNo, float U, float V);
private:
	/// <summary>
	/// �p�C�v���C���X�e�[�g���������B
	/// </summary>
	/// <param name="rs">���[�g�V�O�l�`��</param>
	void InitPipelineState(RootSignature& rs);
	/// <summary>
	/// �V�F�[�_�[�����[�h�B
	/// </summary>
	void LoadShaders();
	/// <summary>
	/// ���_�o�b�t�@���쐬�B
	/// </summary>
	void InitVertexBuffer();
	/// <summary>
	/// �C���f�b�N�X�o�b�t�@���쐬�B
	/// </summary>
	void InitIndexBuffer();

private:
	VertexBuffer m_vertexBuffer;		//���_�o�b�t�@�B
	IndexBuffer m_indexBuffer;		//�C���f�b�N�X�o�b�t�@�B
	Shader m_vertexShader;			//���_�V�F�[�_�[�B
	Shader m_pixelShader;				//�s�N�Z���V�F�[�_�[�B
	PipelineState m_pipelineState;	//�p�C�v���C���X�e�[�g�B
	SimpleVertex m_vertices[4];		//���_�f�[�^�B
};
